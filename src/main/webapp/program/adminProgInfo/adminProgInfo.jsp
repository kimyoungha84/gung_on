<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="kr.co.gungon.program.ProgramService" %>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.gungon.pagination.PaginationBuilder" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>


<%
    String searchPlace = request.getParameter("placeSearchInput");
    if (searchPlace == null) {
        searchPlace = "";
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
    ProgramService pService = new ProgramService();
    
    int pageSize = 7;
    int totalCount = pService.getTotalCount(searchPlace);
    
    PaginationBuilder pb = new PaginationBuilder(request, pageSize, totalCount);
    
    int currentPage = pb.getCurrentPage();
    
    ArrayList<ProgramDTO> program = pService.getAllPrograms();
    List<ProgramDTO> programList = pService.getProgramsByPage(currentPage, pageSize, searchPlace);
    
    int startNo = totalCount - (currentPage - 1) * pageSize;
%>
<link href="../adminProgInfo/adminProgInfo.css" rel="stylesheet" />
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <jsp:include page="${pageContext.request.contextPath}/admin/common/sidebar.jsp" />
        </div>
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <ol class="breadcrumb mb-4 custom-breadcrumb">
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사목록</li>
                    </ol>

                    <form method="get" action="adminProgInfo.jsp">
                        <input class="form-control search-place-input" type="text" name="placeSearchInput"
                               value="<%= searchPlace %>" placeholder="행사장소 검색"
                               onkeydown="submitOnEnter(event)" />
                    </form>

                    <table class="event-table">
                        <thead>
                            <tr>
                                <th class="col-no">No.</th>
                                <th class="col-name">행사</th>
                                <th class="col-place">행사장소</th>
                                <th class="col-period">행사기간</th>
                                <th class="col-contact">담당자</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (programList != null && !programList.isEmpty()) {
                                    int count = 0;
                                    for (ProgramDTO p : programList) {
                                        int displayNo = startNo - count;
                            %>
                                <tr onclick="goToDetail('<%= p.getProgramName() %>')" style="cursor: pointer;">
                                    <td><%= p.getProgramId() %></td>
                                    <td><%= p.getProgramName() %></td>
                                    <td><%= p.getProgramPlace() %></td>
                                    <td><%= sdf.format(p.getStartDate()) %> ~ <%= sdf.format(p.getEndDate()) %></td>
                                    <td><%= p.getContactPerson() %></td>
                                </tr>
                            <%
                                        count++;
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="5">등록된 행사가 없습니다.</td>
                                </tr>
                            <%
                                }
                                String paginationHtml = pb.build(request.getRequestURI());
                            %>
                        </tbody>
                    </table>

                    <nav aria-label="Page navigation">
                        <%= paginationHtml %>
                    </nav>

                    <div class="button-container mt-3">
                        <button class="registerBtn" type="button" onclick="location.href='../adminProgRegister/adminProgRegister.jsp'">등록</button>
                    </div>
                </div>
            </main>
		</div>
	</div>
	
<%@ include file="/admin/common/footer.jsp" %>

    <script>
        function goToDetail(programName) {
            location.href = '../adminProgDetail/adminProgDetail.jsp?programName=' + encodeURIComponent(programName);
        }

        function submitOnEnter(e) {
            if (e.key === "Enter") {
                e.preventDefault();
                e.target.form.submit();
            }
        }
    </script>

</body>
</html>