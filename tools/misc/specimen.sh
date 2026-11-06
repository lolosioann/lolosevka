#!/bin/sh
# Render README specimen images from the built fonts. Run after `npm run build -- ttf::Lolosevka`.
# Transparent background, one image per GitHub theme (text colors from GitHub's palette).
set -e
cd "$(dirname "$0")/../.."
F=dist/Lolosevka/TTF/Lolosevka

render() { # font size text out [border]
	printf '%s' "$3" | magick -background none -fill "$FG" -font "$F-$1.ttf" -pointsize "$2" \
		-gravity West label:@- -bordercolor none -border "${5:-32}" +repage "PNG32:$4"
}

for theme in light dark; do
	if [ "$theme" = light ]; then FG='#1f2328'; else FG='#e6edf3'; fi
	O=images/lolosevka

	render Bold 96 'Lolosevka' "$O-title.$theme.png"

	render Regular 26 'The quick brown fox jumps over the lazy dog.
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.
Ξεσκεπάζω την ψυχοφθόρα βδελυγμία.
0123456789  0O oO 1lI| rnm S5 B8 Z2
!"#$%&()*+,-./:;<=>?@[\]^_{|}~  -> != === <=

#include <stdio.h>

int main(void) {
    for (int i = 0; i < 0x10; i++)
        printf("%d\n", i * i);
    return 0;
}' "$O-specimen.$theme.png"

	S=images/.styles
	for st in Regular Bold Italic BoldItalic; do
		render "$st" 30 "$(printf '%-12s' "$st")The quick brown fox jumps" "$S-$st.png" 32x8
	done
	magick "$S-Regular.png" "$S-Bold.png" "$S-Italic.png" "$S-BoldItalic.png" -background none -append \
		-bordercolor none -border 0x24 +repage "PNG32:$O-styles.$theme.png"
	rm "$S"-*.png
done
