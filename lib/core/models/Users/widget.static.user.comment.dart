class UserCommentModel {
  final String fullName;
  final String imageLink;
  final double voteNumber;
  final String voteContent;
  final int createdDate;
  const UserCommentModel(
      {required this.fullName,
      required this.imageLink,
      required this.voteNumber,
      required this.voteContent,
      required this.createdDate});
}
