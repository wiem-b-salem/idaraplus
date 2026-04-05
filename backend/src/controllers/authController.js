const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const userModel = require('../models/userModel');

const JWT_SECRET = process.env.JWT_SECRET;
if (!JWT_SECRET) {
  throw new Error('Missing JWT_SECRET in .env');
}

const createToken = (user) => {
  return jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, {
    expiresIn: '12h',
  });
};

const authenticate = async (req, res, next) => {
  const authorization = req.headers.authorization;
  if (!authorization || !authorization.startsWith('Bearer ')) {
    return res.status(401).json({ error: 'Authorization header missing or malformed' });
  }

  const token = authorization.split(' ')[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    const user = await userModel.findById(decoded.id);
    if (!user) {
      return res.status(401).json({ error: 'Invalid token user' });
    }

    req.user = user;
    next();
  } catch (error) {
    console.error('JWT authentication failed', error);
    return res.status(401).json({ error: 'Invalid or expired token' });
  }
};

const signup = async (req, res, next) => {
  try {
    const { email, password, role, first_name, last_name, phone, national_id } = req.body;

    if (!email || !password || !role) {
      return res.status(400).json({ error: 'email, password, and role are required' });
    }

    const existingUser = await userModel.findByEmail(email);
    if (existingUser) {
      return res.status(409).json({ error: 'Email already in use' });
    }

    const hashedPassword = await bcrypt.hash(password, 12);
    const user = await userModel.create({
      email,
      password: hashedPassword,
      role,
      first_name,
      last_name,
      phone,
      national_id,
    });

    res.status(201).json({ message: 'User created successfully', user });
  } catch (error) {
    next(error);
  }
};

const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'email and password are required' });
    }

    const user = await userModel.findByEmail(email);
    if (!user || !user.password) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const passwordMatches = await bcrypt.compare(password, user.password);
    if (!passwordMatches) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const token = createToken(user);
    res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        first_name: user.first_name,
        last_name: user.last_name,
        phone: user.phone,
        national_id: user.national_id,
      },
    });
  } catch (error) {
    next(error);
  }
};

const getMe = async (req, res) => {
  const { password, ...userWithoutPassword } = req.user;
  res.json({ user: userWithoutPassword });
};

module.exports = {
  signup,
  login,
  getMe,
  authenticate,
};
