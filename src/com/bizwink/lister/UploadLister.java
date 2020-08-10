package com.bizwink.lister;

import org.apache.commons.fileupload.ProgressListener;

import com.bizwink.cms.entity.Upload;

public class UploadLister implements ProgressListener{
    private Upload upload = null;

    public UploadLister(Upload upload){
        this.upload = upload;
    }

    @Override
    public void update(long uploadSize,long totalSize,int items) {
        upload.setUploadSize(uploadSize);
        upload.setTotalSize(totalSize);
    }
}
