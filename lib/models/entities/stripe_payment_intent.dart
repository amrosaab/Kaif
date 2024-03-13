class StripePaymentIntent {
  const StripePaymentIntent({this.id, this.clientSecret, this.status});

  final String? id;
  final String? clientSecret;
  final String? status;

  bool get isSucceeded => status == 'succeeded';
}
