<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdt" value="${ForwardConst.CMD_EDIT.getValue()}" />
<c:set var="commAlv" value="${ForwardConst.CMD_APPROVAL.getValue()}" />
<c:set var="commAnalv" value="${ForwardConst.CMD_ANAPPROVAL.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
            <c:if test="${flush != null}">
                <div id="flush_success">
                    <c:out value="${flush}"></c:out>
                </div>
            </c:if>
        <h2>日報 詳細ページ</h2>

        <table>
            <tbody>
                <tr>
                    <th>氏名</th>
                    <td><c:out value="${report.employee.name}" /></td>
                </tr>
                <tr>
                    <th>日付</th>
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />
                    <td><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td><pre><c:out value="${report.content}" /></pre></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createDay" type="date" />
                    <td><fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>更新日時</th>
                    <fmt:parseDate value="${report.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updateDay" type="date" />
                    <td><fmt:formatDate value="${updateDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                <c:if test="${report.applovalAt != null}">
                    <th>承認日時</th>
                    <fmt:parseDate value="${report.applovalAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="applovalDay" type="date" />
                    <td><fmt:formatDate value="${applovalDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </c:if>
                </tr>
            </tbody>
        </table>
        <c:if test="${sessionScope.login_employee.id == report.employee.id}">
            <p>
                <a href="<c:url value='?action=${actRep}&command=${commEdt}&id=${report.id}' />">この日報を編集する</a>
            </p>
        </c:if>

        <p>
            <a href="<c:url value='?action=${actRep}&command=${commIdx}' />">一覧に戻る</a>
        </p>
        <p>
           <c:if test="${sessionScope.login_employee.approvalflag == AttributeConst.ROLE_APPROVAL.getIntegerValue()&&report.apploval_employee==null}">
            <a href="<c:url value='?action=${actRep}&command=${commAlv}&id=${report.id}' />">承認</a>
           </c:if>
           <c:if test="${sessionScope.login_employee.approvalflag == AttributeConst.ROLE_APPROVAL.getIntegerValue()&&report.apploval_employee!=null}">
            <a href="<c:url value='?action=${actRep}&command=${commAnalv}&id=${report.id}' />">未承認</a>
           </c:if>
        </p>
    </c:param>
</c:import>