package model;

import java.util.Date;

public class ReportEntry {
    private String reportId;
    private String reportType;
    private Date startDate;
    private Date endDate;
    private Date generatedDate;

    public ReportEntry() {
        this.reportId = "N/A";
        this.reportType = "N/A";
        this.startDate = null;
        this.endDate = null;
        this.generatedDate = null;
    }

    public ReportEntry(String reportId, String reportType, Date startDate, Date endDate, Date generatedDate) {
        this.reportId = reportId;
        this.reportType = reportType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.generatedDate = generatedDate;
    }

    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getGeneratedDate() {
        return generatedDate;
    }

    public void setGeneratedDate(Date generatedDate) {
        this.generatedDate = generatedDate;
    }
}

