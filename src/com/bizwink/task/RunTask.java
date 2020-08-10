package com.bizwink.task;

import com.bizwink.service.LuceneIndexService;
import com.bizwink.util.SpringInit;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RunTask {
    @Scheduled(cron = "0/60 * * * * ? ") // 间隔5秒执行
    public void taskCycle() {
        System.out.println("执行索引生成任务");
        ApplicationContext appContext = SpringInit.getApplicationContext();
        LuceneIndexService luceneIndexService = (LuceneIndexService)appContext.getBean("luceneIndexService");
        luceneIndexService.createIndex();
    }
}
