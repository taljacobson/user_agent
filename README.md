# user_agent
Dart user agent detection library. Uses the code from both `dart:html`
and `package:r2d2`.

Runs anywhere.

```dart
main() async {
    app.before.add('*', (req, res) async {
        var ua = new UserAgent(req.headers.value('user-agent'));

        if (ua.isChrome) {
            res.redirect('/upgrade-your-browser');
            return;
        } else {
            // ...
        }
    });
}
```