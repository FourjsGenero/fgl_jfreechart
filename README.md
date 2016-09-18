# fgl_jfreechart
Library to interact with jfreechart that is shipped inside Genero Report Writer,  This allows you to create chart image files using any of the charts that are available in jfreechart.

Setup...
CLASSPATH needs to include GREDIR/lib/jars/gre.jar

On Mac I found I needed to add --java-option=-Djava.awt.headless=true , to both fglcomp and fglrun

Code I'd expect you to end up with is of the form ...

    IMPORT FGL fgl_jfreechart_spiderwebplot
    
    FUNCTION sample_code()
    DEFINE r fgl_jfreechart_spiderwebplot.spider_web_type

    -- Set paramaters
    LET r.width = 800
    LET r.height = 600
    LET r.title="Spider Web Plot"
    
    -- Read data from database and populate chart with it
    LET r.data = fgl_jfreechart_spiderwebplot.init_data()
    FOREACH ???_cursor INTO data1, data2, value 
        CALL r.data.addValue(value, data1, data2)
    END FOREACH

    -- Create chart
    LET r.filename = "image.png"
    CALL fgl_jfreechart_spiderwebplot.generate(r.*)
    
    END FUNCTION

