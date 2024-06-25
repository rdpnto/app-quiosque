class Register {
  double openingAmount;
  double closureAmount;
  
  late double dailyChange;

  Register(this.openingAmount, this.closureAmount) {
    dailyChange = openingAmount - closureAmount;
  }
}