import java java.io.FileOutputStream
import java java.io.IOException

import java org.jfree.data.category.DefaultCategoryDataset
import java org.jfree.data.category.CategoryDataset
import java org.jfree.chart.ChartFactory
import java org.jfree.chart.JFreeChart
import java org.jfree.chart.plot.SpiderWebPlot
import java org.jfree.chart.title.TextTitle

import java javax.imageio.ImageIO
import java javax.imageio.ImageWriter
import java javax.imageio.stream.ImageOutputStream

import java java.awt.Color
import java java.awt.geom.Rectangle2D
import java java.awt.geom.Rectangle2D.Double
import java java.awt.Graphics2D
import java java.awt.image.BufferedImage

import os

PUBLIC TYPE spider_web_type RECORD
    title STRING,
    width INTEGER,
    height INTEGER,
    data DefaultCategoryDataset,
    filename STRING
END RECORD



FUNCTION init_data()
    RETURN DefaultCategoryDataset.create()
END FUNCTION



FUNCTION generate(rec)
DEFINE rec spider_web_type 

DEFINE bi BufferedImage
DEFINE g Graphics2D
DEFINE r Rectangle2D.Double
DEFINE chart JFreeChart
DEFINE iw ImageWriter
DEFINE out FileOutputStream
DEFINE ios ImageOutputStream
DEFINE swp SpiderWebPlot
DEFINE l_extension STRING

    LET bi = BufferedImage.create(rec.width,rec.height,BufferedImage.TYPE_INT_RGB)

    LET g = bi.createGraphics()

    LET r = Rectangle2D.Double.create(0,0,rec.width,rec.height)
    CALL g.setColor(Color.white)
    CALL g.fill(r)

    LET swp = SpiderWebPlot.create(rec.data)
    LET chart = JFreeChart.create(rec.title, TextTitle.DEFAULT_FONT, swp, true)
    CALL chart.draw(g,r)
    CALL g.dispose()

    LET l_extension = os.Path.extension(rec.filename)
    LET iw = CAST (ImageIO.getImageWritersBySuffix(l_extension).next() AS ImageWriter)
    
    LET out = FileOutputStream.create(rec.filename)

    LET ios = ImageIO.createImageOutputStream(out)

    CALL iw.setOutput(ios)
    CALL iw.write(bi)
    CALL out.flush()
    CALL out.close()
END FUNCTION