class Site {
  String siteName, location, name, telephoneNumber, siteImage, signature;

  Site(this.telephoneNumber, this.name, this.location, this.siteName,
      this.siteImage, this.signature);
}

class Snags {
  String snagLocation,
      snagAssignedTo,
      snagPriority,
      snagTitle,
      snagDescription,
      snagDate,
      closedDate,
      snagImage,
      snagImage1,
      snagImage2,
      snagImage3;
  bool classStatus, confirmedStatus;
  Snags(
      this.snagLocation,
      this.snagAssignedTo,
      this.snagPriority,
      this.snagTitle,
      this.snagDescription,
      this.snagDate,
      this.closedDate,
      this.snagImage,
      this.snagImage1,
      this.snagImage2,
      this.snagImage3,
      this.classStatus,
      this.confirmedStatus);
}
