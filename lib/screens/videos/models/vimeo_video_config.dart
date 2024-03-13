class VimeoVideoConfig {
  VimeoVideoConfig({
    this.request,
  });

  factory VimeoVideoConfig.fromJson(Map<String, dynamic> json) =>
      VimeoVideoConfig(
        request: VimeoRequest.fromJson(json['request']),
      );

  VimeoRequest? request;
}

class VimeoRequest {
  VimeoRequest({
    this.files,
  });

  factory VimeoRequest.fromJson(Map<String, dynamic> json) => VimeoRequest(
        files:
            json['files'] != null ? VimeoFiles.fromJson(json['files']) : null,
      );

  VimeoFiles? files;
}

class VimeoFiles {
  VimeoFiles({
    this.progressive,
  });

  factory VimeoFiles.fromJson(Map<String, dynamic> json) => VimeoFiles(
        progressive: List<VimeoProgressive>.from(
            json['progressive'].map((x) => VimeoProgressive.fromJson(x))),
      );

  List<VimeoProgressive?>? progressive;
}

class VimeoProgressive {
  VimeoProgressive({
    this.url,
    this.quality,
  });

  factory VimeoProgressive.fromJson(Map<String, dynamic> json) =>
      VimeoProgressive(
        url: json['url'],
        quality: json['quality'],
      );

  String? url;
  String? quality;
}
