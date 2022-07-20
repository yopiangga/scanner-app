part of 'services.dart';

class ProsaServices {
  static Future<String> retriveTTS({http.Client client, job_id}) async {
    String url =
        "https://api.prosa.ai/v2/speech/tts/" + job_id + "?as_signed_url=true";

    client ??= http.Client();

    var response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key':
            'eyJhbGciOiJSUzI1NiIsImtpZCI6Ik5XSTBNemRsTXprdE5tSmtNaTAwTTJZMkxXSTNaamN0T1dVMU5URmxObVF4Wm1KaSIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbl9pZCI6NzMyMTQsImxpY2Vuc2Vfa2V5IjoiNDNjZDdjMzAtYjE3Mi00YjgyLWI5ZWMtYmVjM2ZlNjFmYjI1IiwidW5pcXVlX2tleSI6IjVjZjA2NjExLTBlNmMtNDY1ZC1hMzY5LWM5OGU0ZjkwOWI0NSIsInByb2R1Y3RfaWQiOjMsImF1ZCI6ImFwaS1zZXJ2aWNlIiwic3ViIjoiNDQ5Y2ZhOWEtNmEyNy00NGFhLTg5NGItMTY4ZGRjZGM5ZDIxIiwiZXhwIjoxNjg5MTcwMjU4LCJpc3MiOiJjb25zb2xlIiwiaWF0IjoxNjU3NjM0MjU4fQ.ONxPUMrixPBzlRZAYEMAc2DLGw4V3VTud2Hypb6LwNElaaB-4-HF4yEQrknxzcIQTpkX-gh4dIIO0QfJswg8AV5OorqxNBc32dIha3g63Zj2JRtH_qaky-yqwPdAQCt_4Muop8ALTp0aau5LXvs6XtaNsovVKBA43ypUCSHqkNeweHQJ7uGvvI5Hc2IhsXteOPt2BODopT8bE2c6ygrKtXVPjGoQDkYA4YkvCL1-rF9eLJ53on2Ntfu3uEIIJkdJ19bTPyp4-2DBN3EfWjiZo0uj-AkZ2zVVnYowbbLQYVlS4jKHBPJXVzUqYEcqZTFbJBpNzF95WIeDll7ejjG-uw'
      },
    );

    if (response.statusCode != 200) {
      return "";
    }

    final res = json.decode(response.body);

    if (res == null || res['result'] == null) {
      {
        return "";
      }
    }

    var data = res['result']['path'];
    return data;
  }

  static Future<http.Response> submitTTS(List<String> texts) async {
    String url = "https://api.prosa.ai/v2/speech/tts";

    String dataText = texts.join('\\');

    dynamic data = jsonEncode({
      "config": {
        "engine": "tts-dimas-formal",
        "wait": false,
        "pitch": 0,
        "tempo": 1,
        "audio_format": "opus"
      },
      "request": {"label": "string", "text": dataText}
    });

    return http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key':
              'eyJhbGciOiJSUzI1NiIsImtpZCI6Ik5XSTBNemRsTXprdE5tSmtNaTAwTTJZMkxXSTNaamN0T1dVMU5URmxObVF4Wm1KaSIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbl9pZCI6NzMyMTQsImxpY2Vuc2Vfa2V5IjoiNDNjZDdjMzAtYjE3Mi00YjgyLWI5ZWMtYmVjM2ZlNjFmYjI1IiwidW5pcXVlX2tleSI6IjVjZjA2NjExLTBlNmMtNDY1ZC1hMzY5LWM5OGU0ZjkwOWI0NSIsInByb2R1Y3RfaWQiOjMsImF1ZCI6ImFwaS1zZXJ2aWNlIiwic3ViIjoiNDQ5Y2ZhOWEtNmEyNy00NGFhLTg5NGItMTY4ZGRjZGM5ZDIxIiwiZXhwIjoxNjg5MTcwMjU4LCJpc3MiOiJjb25zb2xlIiwiaWF0IjoxNjU3NjM0MjU4fQ.ONxPUMrixPBzlRZAYEMAc2DLGw4V3VTud2Hypb6LwNElaaB-4-HF4yEQrknxzcIQTpkX-gh4dIIO0QfJswg8AV5OorqxNBc32dIha3g63Zj2JRtH_qaky-yqwPdAQCt_4Muop8ALTp0aau5LXvs6XtaNsovVKBA43ypUCSHqkNeweHQJ7uGvvI5Hc2IhsXteOPt2BODopT8bE2c6ygrKtXVPjGoQDkYA4YkvCL1-rF9eLJ53on2Ntfu3uEIIJkdJ19bTPyp4-2DBN3EfWjiZo0uj-AkZ2zVVnYowbbLQYVlS4jKHBPJXVzUqYEcqZTFbJBpNzF95WIeDll7ejjG-uw'
        },
        body: data);
  }
}
