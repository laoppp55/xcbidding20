package com.heaton.bot;

/**
 * This is a very simple object that
 * allows the spider to determine when
 * it is done. This object implements
 * a simple lock that the spider class
 * can wait on to determine completion.
 * Done is defined as the spider having
 * no more work to complete.
 *
 * Copyright 2001-2003 by Jeff Heaton (http://www.jeffheaton.com)
 *
 * @author Jeff Heaton
 * @version 1.2
 */
class SpiderDone {

  /**
   * The number of SpiderWorker object
   * threads that are currently working
   * on something.
   */
  private int activeThreads = 0;

  /**
   * This boolean keeps track of if
   * the very first thread has started
   * or not. This prevents this object
   * from falsely reporting that the spider
   * is done, just because the first thread
   * has not yet started.
   */
  private boolean started = false;
  /**
   * This method can be called to block
   * the current thread until the spider
   * is done.
   */

  synchronized public void waitDone()
  {
    try {
      while ( activeThreads>0 ) {
        wait();
      }
    } catch ( InterruptedException e ) {
    }
  }
  /**
   * Called to wait for the first thread to
   * start. Once this method returns the
   * spidering process has begun.
   */

  synchronized public void waitBegin()
  {
    try {
      while ( !started ) {
        wait();
      }
    } catch ( InterruptedException e ) {
    }
  }


  /**
   * Called by a SpiderWorker object
   * to indicate that it has begun
   * working on a workload.
   */
  synchronized public void workerBegin()
  {
    activeThreads++;
    started = true;
    notify();
  }

  /**
   * Called by a SpiderWorker object to
   * indicate that it has completed a
   * workload.
   */
  synchronized public void workerEnd()
  {
    activeThreads--;
    notify();
  }

  /**
   * Called to reset this object to
   * its initial state.
   */
  synchronized public void reset()
  {
    activeThreads = 0;
  }

}
