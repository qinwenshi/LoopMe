package com.loopme.loopgenerator;

import java.io.FileNotFoundException;

/**
 * Created by gunther on 10/1/16.
 */
public class LoopGeneratorDriver {
    public static void main(String[] args){

        FireDBHelper db = new FireDBHelper();

        LoopGenerator test1 = new LoopGenerator(100, 5, 20);
        test1.generateLoops();

        //db.writeLoopPatterns(test1.getLoops());

        //test1.setLoops(db.getLoopPatterns());
        test1.writeLoopsToTerminal();

    }
}
