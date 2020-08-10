package com.bizwink.webservice.show;

import java.io.Serializable;

public class SpecialData implements Serializable {
        private static final long serialVersionUID = 501760007463772503L;
        private  String pk_special;

        public String getPk_special() {
            return pk_special;
        }

        public void setPk_special(String pk_special) {
            this.pk_special = pk_special;
        }
    }