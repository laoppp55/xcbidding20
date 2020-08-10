package com.bizwink.service;

import com.bizwink.persistence.ArticleClassMapper;
import com.bizwink.po.ArticleClass;
import com.bizwink.vo.TrainMajor;
import com.bizwink.vo.TrainMajorCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ArticleClassService {
    @Autowired
    private ArticleClassMapper articleClassMapper;

    public List<ArticleClass> getTrainCources(BigDecimal articleid) {
       return articleClassMapper.getTrainCources(articleid);
    }

    public List<TrainMajor> getTrainMajors(BigDecimal articleid, String projtypecode) {
        Map params = new HashMap();
        params.put("projcode",projtypecode);
        params.put("articleid",articleid);
        return articleClassMapper.getMajors(params);
    }

    public List<TrainMajorCourse> getTrainCoursesOfMajor(BigDecimal articleid, String majorid, String projtypecode) {
        Map params = new HashMap();
        params.put("projcode",projtypecode);
        params.put("articleid",articleid);
        params.put("majorcode",majorid);
        return articleClassMapper.getCources(params);
    }
}
