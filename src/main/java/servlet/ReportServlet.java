package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ReportEntry;
import model.InventoryItem;
import service.ReportService;
import util.FileHandler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private ReportService reportService;
    private static final String BASE_DIR = System.getProperty("user.dir");
    private static final String DATA_DIR = BASE_DIR + File.separator + "data";

    @Override
    public void init() throws ServletException {
        reportService = new ReportService();

        File dataDir = new File(DATA_DIR);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("generate".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/views/report/addReport.jsp").forward(request, response);
        } else if ("preview".equals(action)) {
            String reportId = request.getParameter("id");
            if (reportId != null && !reportId.isEmpty()) {
                try {
                    List<ReportEntry> reports = reportService.getAllReports();
                    ReportEntry reportEntry = null;

                    for (ReportEntry entry : reports) {
                        if (entry.getReportId().equals(reportId)) {
                            reportEntry = entry;
                            break;
                        }
                    }
                    if (reportEntry != null) {
                        String reportFilePath = reportEntry.getFilePath();

                        if (reportFilePath == null || reportFilePath.isEmpty()) {
                            reportFilePath = DATA_DIR + File.separator +
                                    reportEntry.getReportType().toLowerCase() + "_report.txt";
                        }


                        File reportFile = new File(reportFilePath);

                        if (reportFile.exists()) {
                            StringBuilder content = new StringBuilder();
                            try (BufferedReader reader = new BufferedReader(new FileReader(reportFile))) {
                                String line;
                                while ((line = reader.readLine()) != null) {
                                    content.append(line).append("\n");
                                }
                            }

                            request.setAttribute("reportType", reportEntry.getReportType());
                            request.setAttribute("generatedDate", reportEntry.getGeneratedDate().toString());
                            request.setAttribute("reportContent", content.toString());
                            request.getRequestDispatcher("/WEB-INF/views/report/previewReport.jsp").forward(request, response);
                        } else {
                            request.setAttribute("errorMessage", "Report file not found: " + reportFilePath);
                            doGet(request, response);
                        }
                    } else {
                        request.setAttribute("errorMessage", "Report with ID " + reportId + " not found.");
                        doGet(request, response);
                    }
                }catch (IOException e) {
                    request.setAttribute("errorMessage", "Error reading report: " + e.getMessage());
                    doGet(request, response);
                }
            }else {
                request.setAttribute("errorMessage", "Invalid report ID.");
                doGet(request, response);
            }
        }else {
            try {
                List<InventoryItem> inventoryItems = FileHandler.readItems();
                request.setAttribute("inventoryItems", inventoryItems);

                List<ReportEntry> reports = reportService.getAllReports();
                request.setAttribute("reports", reports);

                request.getRequestDispatcher("/WEB-INF/views/report/viewReports.jsp").forward(request, response);
            } catch (IOException e) {
                request.setAttribute("errorMessage", "Error loading data: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/report/viewReports.jsp").forward(request, response);
            }
        }
    }



}
