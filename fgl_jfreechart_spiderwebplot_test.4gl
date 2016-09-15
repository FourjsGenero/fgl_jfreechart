IMPORT FGL fgl_jfreechart_spiderwebplot
IMPORT util

FUNCTION jfreechart_spiderwebplot_test()
DEFINE r fgl_jfreechart_spiderwebplot.spider_web_type

DEFINE data DYNAMIC ARRAY OF RECORD
    data1 STRING,
    data2 STRING,
    value1 FLOAT
END RECORD
DEFINE i,d1,d2 INTEGER

    LET r.title = "Sample Spider Web Plot"
    LET r.width = 400
    LET r.height = 300
    LET r.filename = "image.png"

    FOR i = 1 TO 10
        LET d1 = (i-1) / 5
        LET d2 = (i-1) MOD 5
        CASE d1
            WHEN 0 LET data[i].data1 = "Monster Truck"
            WHEN 1 LET data[i].data1 = "Drag Racer"
        END CASE
        CASE d2
            WHEN 0 LET data[i].data2 = "Speed"
            WHEN 1 LET data[i].data2 = "Durability"
            WHEN 2 LET data[i].data2 = "Comfort"
            WHEN 3 LET data[i].data2 = "Power"
            WHEN 4 LET data[i].data2 = "Space"
        END CASE
        LET data[i].value1 = util.Math.rand(20)
    END FOR
                        
    

    OPEN WINDOW swp WITH FORM "fgl_jfreechart_spiderwebplot_test"
    DIALOG ATTRIBUTES(UNBUFFERED)
    
        INPUT BY NAME r.title, r.width, r.height, r.filename ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT
        
        INPUT ARRAY data FROM scr_data.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        ON ACTION close
            EXIT DIALOG
        ON ACTION draw ATTRIBUTES(TEXT="Draw")
            LET r.data = fgl_jfreechart_spiderwebplot.init_data()
            FOR i = 1 TO data.getLength()
                CALL r.data.addValue(data[i].value1, data[i].data1, data[i].data2)
            END FOR
            CALL fgl_jfreechart_spiderwebplot.generate(r.*)
            DISPLAY r.filename TO chart
    END DIALOG
            
    CLOSE WINDOW swp
END FUNCTION


{ 
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
}