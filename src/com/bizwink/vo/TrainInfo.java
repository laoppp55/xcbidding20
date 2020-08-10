package com.bizwink.vo;

import com.bizwink.po.TrainingClass;
import com.bizwink.po.TrainingMajor;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class TrainInfo implements Serializable {
    private String projectName;                          //培训项目名称
    private List<TrainingMajor> majorName;                      //选择的专业名称列表
    private Map<String,List<TrainingClass>> classInfos;         //每个专业对应的课程列表，KEY是专业的名称，LIST是专业对应的课程列表

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public List<TrainingMajor> getMajorName() {
        return majorName;
    }

    public void setMajorName(List<TrainingMajor> majorName) {
        this.majorName = majorName;
    }

    public Map<String, List<TrainingClass>> getClassInfos() {
        return classInfos;
    }

    public void setClassInfos(Map<String, List<TrainingClass>> classInfos) {
        this.classInfos = classInfos;
    }
}
