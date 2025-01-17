import pixie/common, pixie/images

when defined(pixieUseStb):
  import pixie/fileformats/stb_image/stb_image

const
  jpgStartOfImage* = [0xFF.uint8, 0xD8]

proc decodeJpg*(data: seq[uint8]): Image {.raises: [PixieError].} =
  ## Decodes the JPEG into an Image.
  when not defined(pixieUseStb):
    raise newException(PixieError, "Decoding JPG requires -d:pixieUseStb")
  else:
    var
      width: int
      height: int
    let pixels = loadFromMemory(data, width, height)

    result = newImage(width, height)
    copyMem(result.data[0].addr, pixels[0].unsafeAddr, pixels.len)

proc decodeJpg*(data: string): Image {.inline, raises: [PixieError].} =
  ## Decodes the JPEG data into an Image.
  decodeJpg(cast[seq[uint8]](data))

proc encodeJpg*(image: Image): string {.raises: [PixieError].} =
  ## Encodes Image into a JPEG data string.
  raise newException(PixieError, "Encoding JPG not supported yet")
