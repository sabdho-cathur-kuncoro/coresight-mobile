class SosFacingController {
  final List<Map<String, String>> companyInputs = [
    {"label": "Company Brand", "facing": "0"},
  ];

  final List<Map<String, String>> competitorInputs = [
    {"label": "Competitor Brand", "facing": "0"},
  ];

  // Get all values with section info
  List<Map<String, String>> getValues() {
    return [
      ...companyInputs.map((m) => {...m, "section": "company"}),
      ...competitorInputs.map((m) => {...m, "section": "competitor"}),
    ];
  }

  // --- Helpers ---
  void addCompanyRow() {
    companyInputs.add({"label": "Company Brand", "facing": "0"});
  }

  void addCompetitorRow() {
    competitorInputs.add({"label": "Competitor Brand", "facing": "0"});
  }

  void removeCompanyRow(int i) {
    if (companyInputs.length > 1) companyInputs.removeAt(i);
  }

  void removeCompetitorRow(int i) {
    if (competitorInputs.length > 1) competitorInputs.removeAt(i);
  }
}
