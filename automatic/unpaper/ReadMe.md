# [Unpaper](https://chocolatey.org/packages/unpaper)

Allows processing of scanned images to perform functions such as splitting two-up pages into separate images. Used in conjunction with OCR software such as OCRmyPDF.

## Overview

`unpaper` is a post-processing tool for scanned sheets of paper, especially for book pages that have been scanned from previously created photocopies.  The main purpose is to make scanned book pages better readable on screen after conversion to PDF. Additionally, `unpaper` might be useful to enhance the quality of scanned pages before performing optical character recognition (OCR).

`unpaper` tries to clean scanned images by removing dark edges that appeared through scanning or copying on areas outside the actual page content (e.g.  dark areas between the left-hand-side and the right-hand-side of a double- sided book-page scan).

The program also tries to detect misaligned centering and rotation of pages and will automatically straighten each page by rotating it to the correct angle. This process is called deskewing.

Note that the automatic processing will sometimes fail. It is always a good idea to manually control the results of unpaper and adjust the parameter settings according to the requirements of the input. Each processing step can also be disabled individually for each sheet.

## Further Information

You can find more information on the [basic concepts](https://github.com/unpaper/unpaper/blob/main/doc/basic-concepts.md) and the [image processing](https://github.com/unpaper/unpaper/blob/main/doc/image-processing.md) in the available documentation.
