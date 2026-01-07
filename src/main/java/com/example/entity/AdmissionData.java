package com.example.entity;

/**
 * 录取数据实体类
 */
public class AdmissionData {
    private int id;
    private int universityId;
    private int majorId;
    private int year;
    private String batch;
    private int minScore;
    private int maxScore;
    private int avgScore;
    private int minRank;
    private int enrollmentCount;
    private String sourceProvince;
    private String universityName;
    private String majorName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUniversityId() { return universityId; }
    public void setUniversityId(int universityId) { this.universityId = universityId; }

    public int getMajorId() { return majorId; }
    public void setMajorId(int majorId) { this.majorId = majorId; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getBatch() { return batch; }
    public void setBatch(String batch) { this.batch = batch; }

    public int getMinScore() { return minScore; }
    public void setMinScore(int minScore) { this.minScore = minScore; }

    public int getMaxScore() { return maxScore; }
    public void setMaxScore(int maxScore) { this.maxScore = maxScore; }

    public int getAvgScore() { return avgScore; }
    public void setAvgScore(int avgScore) { this.avgScore = avgScore; }

    public int getMinRank() { return minRank; }
    public void setMinRank(int minRank) { this.minRank = minRank; }

    public int getEnrollmentCount() { return enrollmentCount; }
    public void setEnrollmentCount(int enrollmentCount) { this.enrollmentCount = enrollmentCount; }

    public String getSourceProvince() { return sourceProvince; }
    public void setSourceProvince(String sourceProvince) { this.sourceProvince = sourceProvince; }

    public String getUniversityName() { return universityName; }
    public void setUniversityName(String universityName) { this.universityName = universityName; }

    public String getMajorName() { return majorName; }
    public void setMajorName(String majorName) { this.majorName = majorName; }
}
