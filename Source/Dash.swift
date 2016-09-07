public class Dash {

    public static let shared = Dash()

    private init() {}

    func show(viewController: UIViewController) {
        // TODO: Delegate to a presenter
        let playerView = PlayerView(frame: viewController.view.bounds)
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
