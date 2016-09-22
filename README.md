# Dash SDK for iOS

Dash provides a smart audio player which turns your app's written content into podcasts.

## Introduction

The fastest way to get started is to use the *shared player*, a singleton provided for your convenience.

### Show the player

```swift
Dash.shared.player.present(over: myView)
Dash.shared.player.present(over: myViewController)
```

### Load an article

```swift
Dash.shared.player.load(url: myArticleUrl)
Dash.shared.player.clear()
```

### Play a loaded article

```swift
Dash.shared.player.play()
Dash.shared.player.pause()
```

### Minimise the player

```swift
Dash.shared.player.minimise()
Dash.shared.player.maximise()
Dash.shared.player.toggle()
```

### Style the player

```swift
Dash.shared.player.theme.colors.foreground = UIColor.blue
Dash.shared.player.theme.alignment.horizontal = .maxXEdge
Dash.shared.player.theme.size = .large
Dash.shared.player.theme.style.padding = 8
Dash.shared.player.theme.images.play = UIImage(named: "play")
```

## Advanced

TODO

- Create and configure player instance manually
- Create multiple players
- Use DI to switch out player’s view or engine
- Implement player's delegate
- Provide custom views
- Full theme listing