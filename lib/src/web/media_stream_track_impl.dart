import 'dart:async';

import '../interface/media_stream_track.dart';

import 'package:dart_webrtc/dart_webrtc.dart' as js;

class MediaStreamTrackWeb extends MediaStreamTrack {
  MediaStreamTrackWeb(this.jsTrack) {
    jsTrack.onended = (event) {
      onEnded?.call();
    };
    jsTrack.onmute = (event) {
      onMute?.call();
    };
  }

  final js.MediaStreamTrack jsTrack;

  @override
  String get id => jsTrack.id;

  @override
  String get kind => jsTrack.kind;

  @override
  String get label => jsTrack.label;

  @override
  bool get enabled => jsTrack.enabled;

  @override
  set enabled(bool b) {
    jsTrack.enabled = b;
  }

  @override
  Future<bool> switchCamera() async {
    // TODO(cloudwebrtc): ???
    return false;
  }

  @override
  Future<void> adaptRes(int width, int height) async {
    // TODO(cloudwebrtc): ???
  }

  @override
  void setVolume(double volume) {
    final constraints = jsTrack.getConstraints();
    constraints['volume'] = volume;
    jsTrack.applyConstraints(constraints);
  }

  @override
  void setMicrophoneMute(bool mute) {
    jsTrack.enabled = !mute;
  }

  @override
  void enableSpeakerphone(bool enable) {
    // Should this throw error?
  }

  @override
  Future<dynamic> captureFrame([String filePath]) async {
    // TODO(cloudwebrtc): ...
    /*
    final imageCapture = html.ImageCapture(jsTrack);
    final bitmap = await imageCapture.grabFrame();
    final html.CanvasElement canvas = html.Element.canvas();
    canvas.width = bitmap.width;
    canvas.height = bitmap.height;
    final html.ImageBitmapRenderingContext renderer =
        canvas.getContext('bitmaprenderer');
    renderer.transferFromImageBitmap(bitmap);
    final dataUrl = canvas.toDataUrl();
    bitmap.close();
    return dataUrl;
    */
  }

  @override
  Future<void> dispose() {
    jsTrack.stop();
    return super.dispose();
  }

  @override
  Future<bool> hasTorch() {
    return Future.value(false);
  }

  @override
  Future<void> setTorch(bool torch) {
    throw UnimplementedError('The web implementation does not support torch');
  }
}
