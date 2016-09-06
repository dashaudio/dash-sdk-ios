public class Dash {

    public static let shared = Dash()

    private init() {}

    func show(viewController: UIViewController) {
        // TODO: Delegate to a presenter
        var frame = viewController.view.bounds
        frame.origin.y = frame.size.height - 50
        frame.size.height = 50
        let playerView = PlayerView(frame: frame)
        playerView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        playerView.delegate = self
        viewController.view.addSubview(playerView)
    }

}

extension Dash: PlayerViewDelegate {

    func playButtonWasPressed() {
        print("Play button was pressed")
    }

    func pauseButtonWasPressed() {
        print("Pause button was pressed")
    }

}
