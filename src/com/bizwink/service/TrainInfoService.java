package com.bizwink.service;

import com.bizwink.persistence.TrainingClassMapper;
import com.bizwink.persistence.TrainingMajorMapper;
import com.bizwink.persistence.TrainingMapper;
import com.bizwink.persistence.TrainingProjectMapper;
import com.bizwink.po.TrainingClass;
import com.bizwink.po.TrainingMajor;
import com.bizwink.po.TrainingProject;
import com.bizwink.vo.TrainInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TrainInfoService {
    @Autowired(required = true)
    private TrainingProjectMapper trainingProjectMapper;

    @Autowired
    private TrainingMajorMapper trainingMajorMapper;

    @Autowired
    private TrainingClassMapper trainingClassMapper;

    @Autowired
    private TrainingMapper trainingMapper;

    public TrainingProject getTrainingProject(String projcode) {
        return trainingProjectMapper.selectByProjCode(projcode);
    }

    public TrainingMajor getTrainingMajorByMajorcode(String majorcode) {
        return trainingMajorMapper.getTrainingMajorByMajorcode(majorcode);
    }

    public TrainInfo getTrainInfoByProjcode(String projcode,String majorcode) {
        TrainInfo trainInfo = new TrainInfo();
        TrainingProject trainingProject = trainingProjectMapper.selectByProjCode(projcode);
        trainInfo.setProjectName(trainingProject.getPROJNAME());

        Map params = new HashMap();
        params.put("PROJCODE",projcode);
        params.put("MAJORCODE",majorcode);
        List<TrainingMajor> trainingMajorList = trainingMajorMapper.getTrainingMajorsForProj(params);
        trainInfo.setMajorName(trainingMajorList);
        Map classMap = new HashMap();
        for(int ii=0;ii<trainingMajorList.size();ii++) {
            TrainingMajor trainingMajor = trainingMajorList.get(ii);
            List<TrainingClass> trainingClassList = trainingClassMapper.getTrainingClassByMajorcode(params);
            classMap.put(trainingMajor.getMAJORCODE(),trainingClassList);
        }
        trainInfo.setClassInfos(classMap);
        return trainInfo;
    }

    public List<TrainingClass> getTrainingClassByProjcode(String projcode) {
        return trainingClassMapper.getTrainingClassByProjcode(projcode);
    }

    public TrainingMajor getMajorinfoByProjcodeAndMajorcode(String projcode,String majorcode) {
        Map params = new HashMap();
        params.put("PROJCODE",projcode);
        params.put("MAJORCODE",majorcode);

        return trainingMajorMapper.getTrainMajor(params);
    }

    public List<TrainingMajor> getMajorsByProjcode(String projcode) {
        return trainingMajorMapper.getTrainingMajorsByProjcode(projcode);
    }
}
