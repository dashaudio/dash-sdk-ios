# Dash SDK for iOS

Dash provides a smart audio player which turns your app's written content into podcasts.


# Themes

    let standardTheme = PlayerTheme()

    let standardColors = PlayerTheme(colors: .standard)
    let grayscaleColors = PlayerTheme(colors: .grayscale)
    let customColors = PlayerTheme(colors: .init(foreground: .green, background: .white))

    let standardAlignment = PlayerTheme(alignment: .standard)
    let customAlignment = PlayerTheme(alignment: .init(horizontal: .maxXEdge, vertical: .minYEdge))

    let standardSize = PlayerTheme(size: .standard)
    let smallSize = PlayerTheme(size: .small)
    let largeSize = PlayerTheme(size: .large)

    let standardStyle = PlayerTheme(style: .standard)
    let customStyle = PlayerTheme(style: .init(rounding: 5, padding: 5))

    let standardImages = PlayerTheme(images: .standard)
    let customImages = PlayerTheme(images: .init(play: UIImage(named:"play")!, pause: UIImage(named: "pause")!))

    let customTheme = PlayerTheme(colours: .grayscale, size: .large, style: .init(rounding: 10, padding: 10))

    Dash.sharedPlayer.theme = customTheme
