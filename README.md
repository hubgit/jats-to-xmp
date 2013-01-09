# jats-to-xmp

Convert JATS XML to XMP

## Usage

    xsltproc --stringparam now `date "+%Y-%m-%d"` jats-to-xmp.xsl example/input.jats.xml