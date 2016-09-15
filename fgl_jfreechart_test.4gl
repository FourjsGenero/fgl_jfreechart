MAIN
    CLOSE WINDOW SCREEN

    OPEN WINDOW w WITH FORM "fgl_jfreechart_test"

    MENU ""
        ON ACTION spiderwebplot
            CALL jfreechart_spiderwebplot_test()
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN