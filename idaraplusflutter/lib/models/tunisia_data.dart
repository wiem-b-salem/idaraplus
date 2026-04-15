// Tunisia's 24 Wilayet (Governorates) and Areas
class TunisiaData {
  static const List<String> wilayet = [
    'Ariana',
    'Béja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kebili',
    'Kef',
    'Mahdia',
    'Manouba',
    'Medenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];

  static Map<String, List<String>> areasByWilaya = {
    'Ariana': ['Ariana Nord', 'Ariana Sud', 'Raoued', 'Kalaat al-Andalous'],
    'Béja': ['Béja', 'Nefza', 'Testur', 'Teboursouk'],
    'Ben Arous': ['Ben Arous', 'Rades', 'Hammam Lif', 'Mohamedia'],
    'Bizerte': ['Bizerte', 'Menzel Bourguiba', 'Ras Jebel', 'Ghar El Mehal'],
    'Gabès': ['Gabès', 'Matmata', 'Ghor El Gharbiah', 'Mareth'],
    'Gafsa': ['Gafsa', 'Metlaoui', 'Redeyef', 'Mdhilla'],
    'Jendouba': ['Jendouba', 'Younga', 'Tabarka', 'Ain Draham'],
    'Kairouan': ['Kairouan', 'Chebika', 'Oueslatia', 'Sbikha'],
    'Kasserine': ['Kasserine', 'Feriana', 'Sbeitla', 'Thala'],
    'Kebili': ['Kebili', 'Douz', 'Soghrane', 'Golfe de Gabès'],
    'Kef': ['Kef', 'Tajerouine', 'Kalaat es-Senam', 'Dahmani'],
    'Mahdia': ['Mahdia', 'El Jem', 'Melloulech', 'Souassi'],
    'Manouba': ['Manouba', 'Mornaguia', 'Ouedhref', 'Borj El Kébli'],
    'Medenine': ['Medenine', 'Djerba', 'Ben Guerdane', 'Zarzis'],
    'Monastir': ['Monastir', 'Jemmal', 'Sayada', 'Téboulba'],
    'Nabeul': ['Nabeul', 'Hammamet', 'Korba', 'Kelibia'],
    'Sfax': ['Sfax', 'Sakiet Ezzit', 'Thyna', 'Kerkennah'],
    'Sidi Bouzid': ['Sidi Bouzid', 'Regueb', 'Skhira', 'Mezzouna'],
    'Siliana': ['Siliana', 'Rouhia', 'Makthar', 'Bargou'],
    'Sousse': ['Sousse', 'Skhira', 'Akouda', 'Kalaa Kebira'],
    'Tataouine': ['Tataouine', 'Ghomrassen', 'Remada', 'Dehiba'],
    'Tozeur': ['Tozeur', 'Naftah', 'Tamerza', 'Gafsa'],
    'Tunis': ['La Marsa', 'Carthage', 'Sidi Bou Saïd', 'Mégrine'],
    'Zaghouan': ['Zaghouan', 'Nadhour', 'El Fahs', 'Bir Mcherga'],
  };

  static List<String> getAreasByWilaya(String wilaya) {
    return areasByWilaya[wilaya] ?? [];
  }

  // Mock data for administrations in each area
  static Map<String, List<String>> administrationsByArea = {
    // Ariana
    'Ariana Nord': ['Poste Ariana 1', 'Poste Ariana 2'],
    'Ariana Sud': ['Poste Ariana Sud', 'Municipalité Ariana'],
    'Raoued': ['Poste Raoued', 'Poste de Police Raoued'],
    
    // Béja
    'Béja': ['Poste Béja Centre', 'Municipalité Béja', 'Recette Finances'],
    'Nefza': ['Poste Nefza', 'Poste de Police'],
    
    // Ben Arous
    'Ben Arous': ['Poste Ben Arous', 'Municipalité Ben Arous'],
    'Rades': ['Poste Rades', 'Recette Rades'],
    
    // Bizerte
    'Bizerte': ['Poste Bizerte', 'Municipalité Bizerte', 'Poste de Police'],
    'Menzel Bourguiba': ['Poste Menzel', 'Recette Finances'],
    
    // Add more area-based data as needed
  };
}
