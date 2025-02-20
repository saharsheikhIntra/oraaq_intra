enum CustomerRequestFilter {
  ongoingJobs("Ongoing Jobs"),
  pendingRequests("Pending Requests"),
  allRequests("All Requests");

  final String value;
  const CustomerRequestFilter(this.value);
}
