import pixie, pixie/fileformats/png

block:
  let mask = newMask(100, 100)
  mask.fill(200)
  mask.applyOpacity(0.5)
  doAssert mask[0, 0] == 100
  doAssert mask[88, 88] == 100

block:
  let mask = newMask(100, 100)
  mask.fill(200)
  mask.invert()
  doAssert mask[0, 0] == 55

block:
  let
    mask = newMask(100, 100)
    r = 10.0
    x = 10.0
    y = 10.0
    h = 80.0
    w = 80.0
  let path = newPath()
  path.moveTo(x + r, y)
#   path.arcTo(x + w, y, x + w, y + h, r)
#   path.arcTo(x + w, y + h, x, y + h, r)
#   path.arcTo(x, y + h, x, y, r)
#   path.arcTo(x, y, x + w, y, r)
  path.roundedRect(x, y, w, h, r, r, r, r)
  mask.fillPath(path)

  let minified = mask.minifyBy2()

  doAssert minified.width == 50 and minified.height == 50

  writeFile("tests/masks/maskMinified.png", minified.encodePng())

block:
  let
    a = readImage("tests/masks/maskMinified.png")
    b = a.magnifyBy2()
  b.writeFile("tests/masks/maskMagnified.png")

block:
  let image = newImage(100, 100)
  image.fill(rgba(255, 100, 100, 255))

  let path = newPath()
  path.ellipse(image.width / 2, image.height / 2, 25, 25)

  let mask = newMask(image.width, image.height)
  mask.fillPath(path)

  image.draw(mask)
  image.writeFile("tests/masks/circleMask.png")

block:
  let a = newMask(100, 100)
  a.fill(255)

  let path = newPath()
  path.ellipse(a.width / 2, a.height / 2, 25, 25)

  let b = newMask(a.width, a.height)
  b.fillPath(path)

  a.draw(b)
  writeFile("tests/masks/maskedMask.png", a.encodePng())

block:
  let a = newMask(100, 100)
  a.fill(255)

  let path = newPath()
  path.ellipse(a.width / 2, a.height / 2, 25, 25)

  let b = newImage(a.width, a.height)
  b.fillPath(path, rgba(0, 0, 0, 255))

  a.draw(b)
  writeFile("tests/masks/imageMaskedMask.png", a.encodePng())

block:
  let path = newPath()
  path.rect(40, 40, 20, 20)

  let a = newMask(100, 100)
  a.fillPath(path)

  a.spread(10)

  writeFile("tests/masks/spread.png", a.encodePng())

block:
  let mask = newMask(100, 100)

  let path = newPath()
  path.ellipse(mask.width / 2, mask.height / 2, 25, 25)

  mask.fillPath(path)
  mask.ceil()

  writeFile("tests/masks/circleMaskSharpened.png", mask.encodePng())

block:
  let path = newPath()
  path.rect(rect(vec2(10, 10), vec2(30, 30)))

  let mask = newMask(100, 100)
  mask.fillPath(path)
  writeFile("tests/masks/drawRect.png", mask.encodePng())

block:
  let path = newPath()
  path.rect(rect(vec2(10, 10), vec2(30, 30)))

  let mask = newMask(100, 100)
  mask.strokePath(path, strokeWidth = 10)
  writeFile("tests/masks/strokeRect.png", mask.encodePng())

block:
  let path = newPath()
  path.roundedRect(rect(vec2(10, 10), vec2(30, 30)), 10, 10, 10, 10)

  let mask = newMask(100, 100)
  mask.fillPath(path)
  writeFile("tests/masks/drawRoundedRect.png", mask.encodePng())

block:
  let path = newPath()
  path.roundedRect(rect(vec2(10, 10), vec2(30, 30)), 10, 10, 10, 10)
  let mask = newMask(100, 100)
  mask.strokePath(path, strokeWidth = 10)
  writeFile("tests/masks/strokeRoundedRect.png", mask.encodePng())

block:
  let path = newPath()
  path.moveTo(vec2(10, 10))
  path.lineTo(vec2(90, 90))

  let mask = newMask(100, 100)
  mask.strokePath(path, strokeWidth = 10)
  writeFile("tests/masks/drawSegment.png", mask.encodePng())

block:
  let path = newPath()
  path.ellipse(vec2(50, 50), 20, 10)

  let mask = newMask(100, 100)
  mask.fillPath(path)
  writeFile("tests/masks/drawEllipse.png", mask.encodePng())

block:
  let path = newPath()
  path.ellipse(vec2(50, 50), 20, 10)

  let mask = newMask(100, 100)
  mask.strokePath(path, strokeWidth = 10)
  writeFile("tests/masks/strokeEllipse.png", mask.encodePng())

block:
  let path = newPath()
  path.polygon(vec2(50, 50), 30, 6)

  let mask = newMask(100, 100)
  mask.fillPath(path)
  writeFile("tests/masks/drawPolygon.png", mask.encodePng())

block:
  let path = newPath()
  path.polygon(vec2(50, 50), 30, 6)

  let mask = newMask(100, 100)
  mask.strokepath(path, strokeWidth = 10)
  writeFile("tests/masks/strokePolygon.png", mask.encodePng())

block:
  let path = newPath()
  path.rect(rect(25, 25, 50, 50))

  let mask = newMask(100, 100)
  mask.fillpath(path)
  mask.blur(20)
  writeFile("tests/images/maskblur20.png", mask.encodePng())

block:
  let path = newPath()
  path.rect(rect(25, 25, 150, 150))

  let mask = newMask(200, 200)
  mask.fillPath(path)
  mask.blur(25)

  let minified = mask.minifyBy2()
  writeFile("tests/masks/minifiedBlur.png", minified.encodePng())
