# AlwaysMap Branding

![](lockup-horizontal-color-light@2x.png)

## Background

Logos, colors, and fonts for AlwaysMap communications and digital assets.
The AlwaysMap color palette draws from the rich tradition of cartographic design, specifically the color conventions established by topographic and thematic mapmakers over centuries.

- **Chartreuse Pear (Primary)** — This warm yellow-green references the hypsometric tints used in topographic maps to indicate lowland vegetation and fertile plains. It evokes the "pear green" pigments found in historic Swiss topographic maps and USGS terrain shading, suggesting growth, journey origins, and the landscapes through which families traveled.

- **Vermilion (Accent)** — A pigment with deep cartographic roots, vermilion has been used since ancient times to mark significant features on maps. In Chinese cartography, cinnabar (the mineral source of vermilion) denoted imperial routes and important destinations. European mapmakers used it for roads, boundaries, and points of arrival. On AlwaysMap, vermilion marks the destination — the culmination of a family's journey.

## Design Principles

- Journey as S-Curve: The icon depicts a serpentine path from origin (white) to destination (vermilion), reflecting the non-linear nature of migration and family movement across geography and time.
- Rounded Corners: The soft container suggests approachability and warmth — this is a product about family heritage, not cold data.
- Josefin Sans Typography: A geometric sans-serif with elegant, vintage Art Deco roots. Its thin strokes and distinctive letterforms convey sophistication with a gentle, approachable warmth — perfect for a product about family heritage and personal journeys.
- Heirloom Quality: Every design choice supports the promise of archival-quality printed maps worthy of framing and passing down through generations.

## Color Usage Guidelines

- Chartreuse Pear is the primary brand color — use it for backgrounds, primary buttons, and the icon container.
- Vermilion is an accent color — use sparingly for CTAs, destination markers, and emphasis.
- Text Dark provides warm contrast on light backgrounds.
- Text Light is optimized for readability on dark backgrounds with a subtle warm tint.

## Generating PNGs

To regenerate PNG files from the SVG sources:

```bash
./generate-pngs.sh
```

This script:
- Uses `resvg` (a secure, static Rust binary) for conversion
- Downloads the Josefin Sans font from Google Fonts to `.fonts/` directory
- Explicitly loads the font into resvg to ensure faithful rendering
- Generates both 1x and 2x resolution PNGs for all SVG files

Prerequisites: `resvg` must be installed (`brew install resvg` on macOS)
