-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ENUM types 
CREATE TYPE user_role AS ENUM ('CITIZEN', 'EMPLOYEE', 'MANAGER', 'ADMIN');
CREATE TYPE request_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'READY', 'DELIVERED');
CREATE TYPE appointment_status AS ENUM ('BOOKED', 'CANCELLED', 'COMPLETED');

-- Core tables
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    national_id VARCHAR(50) UNIQUE, -- from Houweyti
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) NOT NULL, -- CITIZEN, EMPLOYEE, MANAGER, ADMIN
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE procedures (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    required_documents TEXT,
    cost DECIMAL(10,2),
    processing_time_days INT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    procedure_id UUID REFERENCES procedures(id),
    status VARCHAR(20) NOT NULL, -- PENDING, APPROVED, REJECTED, READY, DELIVERED
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP,
    processed_by UUID REFERENCES users(id),
    notes TEXT
);
CREATE TABLE tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    request_id UUID UNIQUE REFERENCES requests(id),
    qr_code TEXT NOT NULL,
    is_used BOOLEAN DEFAULT FALSE,
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE appointments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    procedure_id UUID REFERENCES procedures(id),
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'BOOKED', -- BOOKED, CANCELLED, COMPLETED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    request_id UUID REFERENCES requests(id),
    file_url TEXT NOT NULL,
    file_type VARCHAR(50),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    message TEXT NOT NULL,
    type VARCHAR(50), -- REQUEST_UPDATE, REMINDER, SYSTEM
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    action VARCHAR(255),
    entity_type VARCHAR(50), -- REQUEST, TOKEN, APPOINTMENT
    entity_id UUID,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details JSONB
);

-- replicate : psql -U <username> -d smartidara -f db_setup.sql