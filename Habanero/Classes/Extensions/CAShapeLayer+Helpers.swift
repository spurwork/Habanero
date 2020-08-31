// MARK: - CAShapeLayer (Helpers)

// SOURCE: gist.github.com/freedom27/c709923b163e26405f62b799437243f4
extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint,
                              width: CGFloat,
                              height: CGFloat,
                              color: UIColor) {
        fillColor = color.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - width, y: location.y - height)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: width * 2, height: height * 2))).cgPath
    }
}
