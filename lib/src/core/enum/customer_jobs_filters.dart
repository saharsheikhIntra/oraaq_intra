enum CustomerJobsFilter {
  acceptedRequest("Accepted Requests"),
  pendingRequests("Pending Requests"),
  allRequests("All Requests");

  final String value;
  const CustomerJobsFilter(this.value);
}
