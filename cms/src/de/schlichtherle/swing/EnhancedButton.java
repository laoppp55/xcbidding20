/*
 * EnhancedButton.java
 *
 * Created on 17. Januar 2005, 02:32
 */
/*
 * Copyright 2005 Schlichtherle IT Services
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package de.schlichtherle.swing;

import javax.swing.*;

/**
 * The {@link #setText(String)} method of this subclass of <tt>JButton</tt>
 * scans the string for the first occurence of the character <tt>&</tt> to set
 * the button's mnemonic.
 *
 * @author Christian Schlichtherle
 */
public class EnhancedButton extends JButton {

    public EnhancedButton() {
        super();
    }
    
    public EnhancedButton(Icon icon) {
        super(icon);
    }
    
    public EnhancedButton(String text) {
        super(text);
    }
    
    public EnhancedButton(Action a) {
        super(a);
    }

    public EnhancedButton(String text, Icon icon) {
        super(text, icon);
    }

    /**
     * Sets the text of the button whereby the first single occurence of the
     * character <tt>'&'</tt> is used to determine the next character as the
     * mnemonic for this button.
     * <p>
     * All single occurences of <tt>'&'</tt> are removed from the text
     * and all double occurences are replaced by a single <tt>'&'</tt>
     * before passing the result to the super classes implementation.
     * <p>
     * Note that if the resulting text is HTML, the index of the mnemonic
     * character is ignored and the look and feel will (if at all) highlight
     * the first occurence of the mnemonic character.
     */
    public void setText(String text) {
        if (text != null) {
            MnemonicText ti = new MnemonicText(text);
            text = ti.getText();
            super.setText(text);
            if (ti.getMnemonicIndex() >= 0) {
                setMnemonic(ti.getMnemonic());
                if (!ti.isHtmlText())
                    setDisplayedMnemonicIndex(ti.getMnemonicIndex());
            }
        } else {
            super.setText(null);
        }
    }
}
