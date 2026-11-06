#!/bin/sh
# Render README specimen images from the built fonts. Run after `npm run build -- ttf::Lolosevka`.
set -e
cd "$(dirname "$0")/../.."
F=dist/Lolosevka/TTF/Lolosevka
BG='#1e1e1e'
FG='#dddddd'
render() { # font size text out [border]
	printf '%s' "$3" | magick -background "$BG" -fill "$FG" -font "$F-$1.ttf" -pointsize "$2" \
		-gravity West label:@- -bordercolor "$BG" -border "${5:-32}" "PNG24:$4"
}

render Bold 96 'Lolosevka' images/lolosevka-title.png

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
}' images/lolosevka-specimen.png

S=images/.styles
for st in Regular Bold Italic BoldItalic; do
	render "$st" 30 "$(printf '%-12s' "$st")The quick brown fox jumps" "$S-$st.png" 32x8
done
magick "$S-Regular.png" "$S-Bold.png" "$S-Italic.png" "$S-BoldItalic.png" -background "$BG" -append \
	-bordercolor "$BG" -border 0x24 PNG24:images/lolosevka-styles.png
rm "$S"-*.png
