enum RequestStatusEnum {
  cancelled("Cancelled", "cencelled"),
  inProgress("In Progress", "In Progress"),
  pending("Pending", "Pending"),
  open("Open", "Open"),
  completed("Completed", "completed");

  final String name;
  final String value;
  const RequestStatusEnum(
    this.name,
    this.value,
  );
}
