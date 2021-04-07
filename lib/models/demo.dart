class Demo {
  int code;
  Result result;
  String msg;
  int status;
  int timestamp;

  Demo({this.code, this.result, this.msg, this.status, this.timestamp});

  Demo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    msg = json['msg'];
    status = json['status'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Result {
  String data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}
