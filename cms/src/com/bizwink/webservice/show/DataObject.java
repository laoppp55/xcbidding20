package com.bizwink.webservice.show;

import java.io.Serializable;
import java.util.List;

public  class DataObject implements Serializable {

        private static final long serialVersionUID = 4268736971251458170L;

        private String pk_tranprotype;

        private List<ClasssetbodysData> classsetbodys;

        private List<SpecialbodysData> specialbodys;

       public String getPk_tranprotype() {
           return pk_tranprotype;
       }

       public void setPk_tranprotype(String pk_tranprotype) {
           this.pk_tranprotype = pk_tranprotype;
       }

       public List<ClasssetbodysData> getClasssetbodys() {
           return classsetbodys;
       }

       public void setClasssetbodys(List<ClasssetbodysData> classsetbodys) {
           this.classsetbodys = classsetbodys;
       }

       public List<SpecialbodysData> getSpecialbodys() {
           return specialbodys;
       }

       public void setSpecialbodys(List<SpecialbodysData> specialbodys) {
           this.specialbodys = specialbodys;
       }
   }