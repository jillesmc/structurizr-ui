<%@ include file="/WEB-INF/fragments/workspace/javascript.jspf" %>

<%-- JointJS --%>
<link href="${structurizrConfiguration.cdnUrl}/css/joint-3.6.5.css" rel="stylesheet" media="screen" />
<script src="${structurizrConfiguration.cdnUrl}/js/lodash-4.17.21.js"></script>
<script src="${structurizrConfiguration.cdnUrl}/js/backbone-1.4.1.js"></script>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/joint-3.6.5.js"></script>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/dagre-0.7.3.min.js"></script>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/graphlib-2.1.3.min.js"></script>

<%-- PNG export --%>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/canvg-1.5.4.js"></script>

<%-- creating animated GIFs --%>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/gifshot-0.4.4.js"></script>

<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/structurizr-diagram${structurizrConfiguration.versionSuffix}.js"></script>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/structurizr-ui${structurizrConfiguration.versionSuffix}.js"></script>
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/structurizr-scripting-diagram${structurizrConfiguration.versionSuffix}.js"></script>

<link href="${structurizrConfiguration.cdnUrl}/css/structurizr-diagram.css" rel="stylesheet" media="screen" />

<c:if test="${structurizrConfiguration.type ne 'lite'}">
<script type="text/javascript" src="${structurizrConfiguration.cdnUrl}/js/structurizr-lock${structurizrConfiguration.versionSuffix}.js"></script>
</c:if>

<c:choose>
    <c:when test="${workspace.editable eq false && embed eq true && showDiagramSelector eq true}">
        <%-- embedded mode, with the diagram selector --%>
        <div id="diagramControls" class="form-group centered" style="margin-bottom: 0px;">
            <div class="btn-group">
                <select id="viewType" class="form-control" style="font-size: 12px;"></select>
            </div>
        </div>
    </c:when>
    <c:when test="${workspace.editable eq false && embed eq true && showDiagramSelector eq false}">
        <%-- embedded mode, without the diagram selector --%>
    </c:when>
    <c:otherwise>
        <div id="diagramControls">
            <c:choose>
                <c:when test="${embed eq true}">
                    <div class="centered">
                        <%@ include file="/WEB-INF/fragments/diagrams/controls.jspf" %>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <div class="col-sm-2" style="padding: 18px 20px 10px 20px">
                            <a href="${urlPrefix}${urlSuffix}"><img src="${structurizrConfiguration.cdnUrl}/img/structurizr-banner.png" alt="Structurizr" class="structurizrBannerLight img-responsive brandingLogo" /><img src="${structurizrConfiguration.cdnUrl}/img/structurizr-banner-dark.png" alt="Structurizr" class="structurizrBannerDark img-responsive brandingLogo" /></a>
                        </div>
                        <div class="col-sm-10 centered" style="padding: 20px 30px 0px 30px">
                            <div class="centered">
                                <%@ include file="/WEB-INF/fragments/diagrams/controls.jspf" %>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:otherwise>
</c:choose>

<div class="row" style="padding: 0; margin: 0">
    <div id="diagramNavigationPanel" class="col-sm-2 hidden-xs hidden-sm <c:if test="${embed eq true}">hidden</c:if>">
        <c:if test="${not empty param.version}">
        <div class="centered" style="margin-top: 10px;">
            <span class="label label-version" style="font-size: 11px"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/clock-history.svg" class="icon-xs icon-white" /> ${workspace.internalVersion}</span>
        </div>
        </c:if>

        <div id="diagramNavigation" style="padding-top: 15px"></div>
    </div>

    <div class="col-sm-10" style="padding: 0">
        <div id="diagram" tabindex="1" style="position: relative">
        </div>
    </div>
</div>

<div id="embeddedControls" style="text-align: right; position: absolute; bottom: 10px; right: 10px; opacity: 0.1; z-index: 100;">
    <div class="btn-group">
        <button class="btn btn-default" title="Zoom out [-]" onclick="structurizr.diagram.zoomOut()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/zoom-out.svg" class="icon-btn" /></button>
        <button id="enterPresentationModeButton" class="btn btn-default hidden" title="Enter Presentation Mode [p]" onclick="enterPresentationMode()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/easel.svg" class="icon-btn" /></button>
        <button class="btn btn-default" title="Zoom in [+]" onclick="structurizr.diagram.zoomIn()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/zoom-in.svg" class="icon-btn" /></button>
    </div>

    <c:if test="${showDiagramSelector eq true}">
        <button class="btn btn-default backButton" title="Go back to previous diagram" onclick="back()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/arrow-90deg-left.svg" class="icon-btn" /></button>
    </c:if>

    <div class="btn-group">
        <button class="btn btn-default hidden dynamicDiagramButton stepBackwardAnimationButton" title="Step backward [,]" onclick="stepBackwardInAnimation()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/skip-backward.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden dynamicDiagramButton startAnimationButton" title="Play animation" onclick="startAnimation(true)"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/play.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden dynamicDiagramButton stopAnimationButton" title="Stop animation" onclick="stopAnimation(true)"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/stop.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden dynamicDiagramButton stepForwardAnimationButton" title="Step forward [.]" onclick="stepForwardInAnimation()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/skip-forward.svg" class="icon-btn" /></button>
    </div>

    <c:if test="${embed eq true}">
    <div class="btn-group">
        <button class="btn btn-default" title="Diagram key [i]" onclick="showKey()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/info-circle.svg" class="icon-btn" /></button>
        <button class="btn btn-default diagramTooltipOnButton" title="Diagram tooltips on [t]" onclick="toggleTooltip()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/chat-square-text.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden diagramTooltipOffButton" title="Diagram tooltips off [t]" onclick="toggleTooltip()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/chat-square-text-fill.svg" class="icon-btn" /></button>
        <button class="btn btn-default" id="tagsOnButton" title="Tags" onclick="openTagsModal()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/tags.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden" id="tagsOffButton" title="Tags" onclick="openTagsModal()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/tags-fill.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden" id="perspectivesOnButton" title="Perspectives" onclick="openPerspectivesModal()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/binoculars.svg" class="icon-btn" /></button>
        <button class="btn btn-default hidden" id="perspectivesOffButton" title="Perspectives" onclick="openPerspectivesModal()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/binoculars-fill.svg" class="icon-btn" /></button>
        <c:if test="${workspace.id > 0 && (embed eq true && workspace.editable eq false)}">
        <button class="btn btn-default" title="Link to this diagram" onclick="openCurrentDiagramInNewWindow()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/link.svg" class="icon-btn" /></button>
        </c:if>
        <button class="btn btn-default" title="Export diagram and key/legend to PNG" onclick="exportToPNG()"><img src="${structurizrConfiguration.cdnUrl}/bootstrap-icons/filetype-png.svg" class="icon-btn" /></button>
    </div>
    </c:if>
</div>

<style>
    #diagram {
        background: gray;
        margin: 0;
        padding: 0;
        border-style: none;
    }

    .diagramThumbnail {
        cursor: pointer;
        margin: 0 0 40px 0;
        padding: 10px;
        border-radius: 5px;
    }

    .diagramThumbnailActive {
        background: #aaaaaa;
        color: #ffffff;
    }
</style>

<%@ include file="/WEB-INF/fragments/progress-message.jspf" %>
<%@ include file="/WEB-INF/fragments/quick-navigation.jspf" %>
<%@ include file="/WEB-INF/fragments/tooltip.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/key.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/export.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/navigation.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/perspectives.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/tags.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/autolayout.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/no-views-model.jspf" %>
<%@ include file="/WEB-INF/fragments/diagrams/lasso.jspf" %>

<script nonce="${scriptNonce}">

    progressMessage.show('<p>Loading workspace...</p>');

    const DARK_MODE_COOKIE_NAME = 'structurizr.darkMode';
    structurizr.constants.DEFAULT_FONT_NAME = "Open Sans";

    var views;
    const viewKeys = [];
    var viewsVisited = new structurizr.util.Stack();
    var unsavedChanges = false;
    var publishThumbnails = ${publishThumbnails};
    var presentationMode = false;

    function workspaceLoaded() {
        if (!structurizr.workspace.hasViews()) {
            openNoViewsModal();
            return;
        } else {
            views = structurizr.workspace.getViews();
        }

        structurizr.ui.loadThemes(function() {
            // if automatic layout (with Graphviz) needs to be executed, lets do this first
            if (graphvizRequired()) {
                runGraphvizForWorkspace(init);
            } else {
                init();
            }
        });
    }

    function graphvizRequired() {
        var result = false;

        views.forEach(function(view) {
            if (view.type === structurizr.constants.FILTERED_VIEW_TYPE) {
                view = structurizr.workspace.findViewByKey(view.baseViewKey);
            }
            if (view.automaticLayout && view.automaticLayout.implementation === 'Graphviz') {
                result = true;
            }
        });

        return result && ${structurizrConfiguration.graphvizEnabled};
    }

    function runGraphvizForWorkspace(callback) {
        var url = '${structurizrConfiguration.graphvizUrl}';
        runGraphviz(url, callback);
    }

    function runGraphvizForView(rankDirection, rankSeparation, nodeSeparation, edgeSeparation, linkVertices, margin, resize, callback) {
        const view = structurizr.diagram.getCurrentView();
        var url = '${structurizrConfiguration.graphvizUrl}?view=' + view.key + '&resizePaper=' + resize + '&rankDirection=' + rankDirection + '&rankSeparation=' + rankSeparation + '&nodeSeparation=' + nodeSeparation + '&margin=' + margin

        runGraphviz(url, callback);
    }

    function runGraphviz(url, callback) {
        $.ajax({
            url: url,
            type: 'POST',
            contentType: 'application/json; charset=UTF-8',
            cache: false,
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            dataType: 'json',
            data: getMinimalJson()
        })
        .done(function(data, textStatus, jqXHR) {
            if (data.views) {
                structurizr.workspace.copyLayoutFrom(data.views);
            }
            callback();
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            progressMessage.hide();

            console.log('Automatic layout failed');
            logError(jqXHR, textStatus, errorThrown);
        });
    }

    function getMinimalJson() {
        const workspace = structurizr.workspace.getJson();
        delete workspace.properties['structurizr.dsl'];
        delete workspace.documentation;

        if (workspace.model.softwareSystems) {
            workspace.model.softwareSystems.forEach(function (softwareSystem) {
                delete softwareSystem.documentation;

                if (softwareSystem.containers) {
                    softwareSystem.containers.forEach(function (container) {
                        delete container.documentation;
                    });
                }
            });
        }

        return JSON.stringify(workspace, null, '    ');
    }

    function init() {
        if (structurizr.workspace.id > 0) { // i.e. not a demo page
            initThumbnails();
        }

        structurizr.ui.applyBranding();

        structurizr.diagram = new structurizr.ui.Diagram('diagram', ${workspace.editable}, diagramCreated);
        structurizr.diagram.setEmbedded(${embed});
        setDarkMode(document.cookie.indexOf(DARK_MODE_COOKIE_NAME + '=true') > -1);

        structurizr.diagram.setTooltip(tooltip);
        structurizr.diagram.setLasso(lasso);
        structurizr.diagram.setNavigationEnabled(${(embed eq true && workspace.id == 0) || embed eq false || showDiagramSelector eq true});
        structurizr.diagram.onWorkspaceChanged(workspaceChanged);
        structurizr.diagram.onElementDoubleClicked(elementDoubleClicked);
        structurizr.diagram.onRelationshipDoubleClicked(relationshipDoubleClicked);
        structurizr.diagram.onElementsSelected(toggleMultiSelectButtons);
        structurizr.diagram.onViewChanged(viewChanged);
        structurizr.diagram.onAnimationStarted(animationStarted);
        structurizr.diagram.onAnimationStopped(animationStopped);

        initPerspectives();
        initTags();
        initAutoLayout();

        <c:if test="${not empty perspective}">
        structurizr.diagram.changePerspective('${perspective}');
        </c:if>

        <c:if test="${showDiagramSelector eq true}">
        initDiagramSelector();
        </c:if>

        initQuickNavigation();
        initExports();
        initSizing();
        initControls();
        initKeyboardShortcuts();

        // todo
<%--        <c:if test="${structurizrConfiguration.type ne 'lite'}">--%>
<%--        initReview();--%>
<%--        <c:if test="${workspace.editable && workspace.ownerUserType.allowedToLockWorkspaces && not empty workspace.apiKey}">--%>
<%--        new Structurizr.Lock(${workspace.id}, '${workspace.apiKey}', 'structurizr-web/${version.buildNumber}', false);--%>
<%--        </c:if>--%>
<%--        </c:if>--%>

        progressMessage.hide();
    }

    function viewChanged(key) {
        $('#keyModal').modal('hide');

        const view = structurizr.workspace.findViewByKey(key);

        $('#undoButton').prop('disabled', true);

        if (viewsVisited.peek() !== key) {
            viewsVisited.push(key);
        }
        $('.backButton').attr("disabled", viewsVisited.count() === 1);

        selectDiagramByView(view);

        const editable = structurizr.diagram.isEditable();
        if (!editable) {
            $('#diagramEditButtons').addClass('hidden');
            $('#editDiagramButton').addClass('hidden');
            $('#diagramNotEditableMessage').removeClass('hidden');
        } else {
            $('#diagramEditButtons').removeClass('hidden');
            $('#editDiagramButton').removeClass('hidden');
            $('#diagramNotEditableMessage').addClass('hidden');
        }

        structurizr.diagram.resize();
        structurizr.diagram.zoomToWidthOrHeight();

        // disable some UI elements based upon whether the diagram is editable
        $('#autoLayoutButton').prop('disabled', !editable);
        $('#magnetButton').prop('disabled', !editable);
        getPageSizeDropDown().prop('disabled', !editable);

        $('.multipleElementsSelectedButton').prop('disabled', true);

        if (
            view.type === structurizr.constants.SYSTEM_CONTEXT_VIEW_TYPE ||
            view.type === structurizr.constants.CONTAINER_VIEW_TYPE ||
            view.type === structurizr.constants.COMPONENT_VIEW_TYPE ||
            (view.type === structurizr.constants.DYNAMIC_VIEW_TYPE && view.elementId !== undefined) ||
            (view.type === structurizr.constants.DEPLOYMENT_VIEW_TYPE && view.softwareSystemId !== undefined)
        ) {
            $('#showDiagramScopeOnButton').removeClass('hidden');
            $('#showDiagramScopeOffButton').addClass('hidden');
        } else {
            $('#showDiagramScopeOnButton').addClass('hidden');
            $('#showDiagramScopeOffButton').addClass('hidden');
        }

        // // set the view key in the embed code modal
        // todo
        // $(".diagramEmbedDiagramId").html("" + encodeURIComponent(view.key));

        if (view.type === "Dynamic" || view.animations.length > 1) {
            $('.dynamicDiagramButton').removeClass("hidden");

            $('.stepBackwardAnimationButton').attr("disabled", true);
            $('.startAnimationButton').attr("disabled", false);
            $('.stopAnimationButton').attr("disabled", true);
            $('.stepForwardAnimationButton').attr("disabled", false);
        } else {
            $('.dynamicDiagramButton').addClass("hidden");
        }

        const explorationsButton = document.getElementById('explorationsButton');
        if (explorationsButton) {
            if (view.type === 'Custom' || view.type === 'SystemLandscape' || view.type === 'SystemContext' || view.type === 'Container' || view.type === 'Component') {
                explorationsButton.onclick = function () {
                    var queryString;
                    const urlPrefix = '${urlPrefix}';
                    const urlSuffix = '${urlSuffix}';

                    if (urlSuffix.length === 0) {
                        queryString = '?';
                    } else {
                        queryString = (urlSuffix + '&');
                    }
                    queryString += ('view=' + encodeURIComponent(view.key));
                    window.open(urlPrefix + '/explore/graph' + queryString);
                };

                $('#explorationsButton').removeClass('hidden');
            } else {
                $('#explorationsButton').addClass('hidden');
            }
        }

        refreshThumbnail();
    }

    function refreshThumbnail() {
        if (structurizr.workspace.id < 1 || structurizr.diagram.isDarkMode() === true || structurizr.diagram.hasPerspective() || structurizr.diagram.hasTags()) {
            structurizr.diagram.exportCurrentThumbnailToPNG(function(thumbnail) {
                const viewKey = structurizr.diagram.getCurrentViewOrFilter().key;
                const domId = '#diagram' + (viewKeys.indexOf(viewKey) + 1) + 'Thumbnail';
                $(domId + ' img').attr('src', thumbnail);

                if (publishThumbnails) {
                    putImage(viewKey, viewKey + '-thumbnail.png', thumbnail);

                    // and if this is the first view, make this the workspace thumbnail
                    if (viewKey === views[0].key) {
                        putImage(viewKey, 'thumbnail.png', thumbnail);
                    }
                }
            });
        }
    }

    function workspaceChanged() {
        $('#undoButton').prop('disabled', structurizr.diagram.undoStackIsEmpty());
        $('#saveButton').prop('disabled', false);
        $('#saveButton').addClass('btn-danger');
        unsavedChanges = true;
    }

    function selectDiagramByView(view)
    {
        $('#viewType option[value="' + view.key + '"]').prop('selected', true);

        if (structurizr.workspace.id > 0) {
            $('.diagramThumbnail').removeClass('diagramThumbnailActive');
            var index = 1;
            views.forEach(function (v) {
                if (view.key === v.key) {
                    const thumbnail = $('#diagram' + index + 'Thumbnail');
                    thumbnail.addClass('diagramThumbnailActive');
                }
                index++;
            });

            scrollActiveThumbnailIntoView();
        }
    }

    function scrollActiveThumbnailIntoView() {
        // scroll the thumbnail into view
        var diagramNavigation = $('#diagramNavigationPanel');
        var thumbnail = $('.diagramThumbnailActive');
        if (diagramNavigation.length > 0 && thumbnail.length > 0) {
            if (thumbnail.offset().top < diagramNavigation.offset().top) {
                thumbnail[0].scrollIntoView(true);
            } else if ((thumbnail.offset().top + thumbnail.height()) > (diagramNavigation.offset().top + diagramNavigation.height())) {
                thumbnail[0].scrollIntoView(false);
            }
        }
    }

    function back() {
        if (viewsVisited.count() > 1) {
            viewsVisited.pop();
            const key = viewsVisited.peek();
            window.location.hash = encodeURIComponent(key);
        }
    }

    function initThumbnails() {
        var html = '';
        var index = 1;
        views.forEach(function(view) {
            viewKeys.push(view.key);
            var id = 'diagram' + index;
            var title = structurizr.util.escapeHtml(structurizr.ui.getViewName(view));

            html += '<div id="' + id + 'Thumbnail" class="diagramThumbnail centered small">';

            <c:choose>
            <c:when test="${not empty param.version or embed eq true}">
            html += '  <img src="/static/img/thumbnail-not-available.png" class="img-thumbnail" style="margin-bottom: 10px" /></a>';
            </c:when>
            <c:otherwise>
            html += '  <img src="${thumbnailUrl}' + structurizr.util.escapeHtml(view.key) + '-thumbnail.png" class="img-thumbnail" style="margin-bottom: 10px;" onerror="this.onerror = null; this.src=\'/static/img/thumbnail-not-available.png\';" /><br />';
            </c:otherwise>
            </c:choose>

            html += title;
            html += '<br /><span class="small">#' + structurizr.util.escapeHtml(view.key) + '</span>';
            html += '</div>';

            index++;
        });

        $('#diagramNavigation').append(html);

        index = 1;
        views.forEach(function(view) {
            document.getElementById('diagram' + index + 'Thumbnail').onclick = function() {
                window.location.hash = encodeURIComponent(view.key);
            };

            index++;
        });
    }

    function initDiagramSelector() {
        const viewsDropDown = $('#viewType');
        viewsDropDown.empty();

        views.forEach(function(view) {
            viewsDropDown.append(
                $('<option></option>').val(structurizr.util.escapeHtml(view.key)).html(structurizr.util.escapeHtml(structurizr.ui.getViewName(view)))
            );
        });
    }

    function openCurrentDiagramInNewWindow() {
        var hash = window.location.hash;
        if (hash === undefined || hash.trim().length === 0) {
            window.open('${urlPrefix}/diagrams${urlSuffix}#${diagramIdentifier}');
        } else {
            window.open('${urlPrefix}/diagrams${urlSuffix}#' + window.location.hash.substring(1))
        }
    }

    function initSizing() {
        structurizr.diagram.getPossibleViewportWidth = function() {
            const diagramNavigation = $('#diagramNavigationPanel');
            var diagramNavigationWidth = 0;
            if (diagramNavigation && diagramNavigation.is(':visible')) {
                diagramNavigationWidth = diagramNavigation.outerWidth();
            }

            if (structurizr.ui.isFullScreen()) {
                return screen.width - diagramNavigationWidth;
            } else {

                const diagramDefinition = $('#diagramDefinition');
                if (diagramDefinition && diagramDefinition.is(':visible')) {
                    return window.innerWidth - diagramDefinition.innerWidth() - diagramNavigationWidth;
                } else {
                    return window.innerWidth - diagramNavigationWidth;
                }
            }
        };

        structurizr.diagram.getPossibleViewportHeight = function() {
            const diagramControlsHeight = $('#diagramControls').outerHeight(true);

            if (structurizr.ui.isFullScreen()) {
                if (presentationMode) {
                    return screen.height;
                } else {
                    return screen.height - diagramControlsHeight;
                }
            } else {
                return window.innerHeight - diagramControlsHeight;
            }
        };
    }

    function initControls() {
        $('#editorButton').prop('disabled', !${workspace.editable});
        if (!structurizr.workspace.hasDocumentation()) {
            $('#documentationButton').addClass('hidden');
        }
        if (!structurizr.workspace.hasDecisions()) {
            $('#decisionLogButton').addClass('hidden');
        }

        if (structurizr.ui.isFullScreenEnabled()) {
            $('#enterPresentationModeButton').removeClass('hidden');
        }
    }

    function toggleDarkMode() {
        setDarkMode(!structurizr.diagram.isDarkMode());
    }

    function setDarkMode(bool) {
        if (bool) {
            structurizr.diagram.setDarkMode(true);
            document.cookie = DARK_MODE_COOKIE_NAME + '=true; expires=31 Dec 2029 23:59:59 UTC; path=/';
            $('#darkModeOnButton').addClass('hidden');
            $('#darkModeOffButton').removeClass('hidden');
        } else {
            structurizr.diagram.setDarkMode(false);
            document.cookie = DARK_MODE_COOKIE_NAME + '=; expires=01 Jan 1970 00:00:00 UTC; path=/';
            $('#darkModeOnButton').removeClass('hidden');
            $('#darkModeOffButton').addClass('hidden');
        }
    }

    function initKeyboardShortcuts() {
        structurizr.diagram.onkeydown(function(e) {
            const leftArrow = 37;
            const pageUp = 33;
            const rightArrow = 39;
            const pageDown = 34;
            const upArrow = 38;
            const downArrow = 40;

            if (structurizr.diagram.isNavigationEnabled()) {
                if (e.which === leftArrow || e.which === upArrow || e.which === pageUp) {
                    navigateToPreviousDiagram();
                    e.preventDefault();
                    return;
                } else if (e.which === rightArrow || e.which === downArrow || e.which === pageDown) {
                    navigateToNextDiagram();
                    e.preventDefault();
                    return;
                }
            }
        });

        structurizr.diagram.onkeypress(function(e) {
            const plus = 43;
            const equals = 61;
            const minus = 45;
            const comma = 44;
            const dot = 46;
            const a = 97;
            const b = 98;
            const c = 99;
            const d = 100;
            const f = 102;
            const h = 104;
            const i = 105;
            const l = 108;
            const m = 109;
            const n = 110;
            const p = 112;
            const r = 114;
            const t = 116;
            const u = 117;
            const v = 118;
            const w = 119;

            if (e.which === comma) {
                if (structurizr.diagram.currentViewIsDynamic() || structurizr.diagram.currentViewHasAnimation()) {
                    stepBackwardInAnimation();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === dot) {
                if (structurizr.diagram.currentViewIsDynamic() || structurizr.diagram.currentViewHasAnimation()) {
                    stepForwardInAnimation();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === a) {
                if (structurizr.diagram.isEditable()) {
                    structurizr.diagram.selectAllElements();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === d) {
                if (structurizr.diagram.isEditable() && structurizr.diagram.hasElementsSelected()) {
                    structurizr.diagram.deselectAllElements();
                    e.preventDefault();
                    return;
                } else {
                    structurizr.diagram.toggleDescription();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === m) {
                structurizr.diagram.toggleMetadata();
                e.preventDefault();
                return;
            } else if (e.which === plus || e.which === equals) {
                structurizr.diagram.zoomIn();
                e.preventDefault();
                return;
            } else if (e.which === minus) {
                structurizr.diagram.zoomOut();
                e.preventDefault();
                return;
            } else if (e.which === w) {
                structurizr.diagram.zoomFitWidth();
                e.preventDefault();
                return;
            } else if (e.which === h) {
                structurizr.diagram.zoomFitHeight();
                e.preventDefault();
                return;
            } else if (e.which === c) {
                structurizr.diagram.zoomFitContent();
                e.preventDefault();
                return;
            } else if (e.which === u) {
                structurizr.diagram.undo();
                e.preventDefault();
                return;
            } else if (e.which === n && structurizr.diagram.isEditable()) {
                var regex = prompt("Please enter a regex.", "");
                if (regex !== undefined) {
                    structurizr.diagram.selectElementsWithName(regex);
                }
                e.preventDefault();
                return;
            } else if (e.which === r) {
                if (structurizr.diagram.hasLinkHighlighted() && structurizr.diagram.isEditable()) {
                    structurizr.diagram.toggleRoutingOfHighlightedLink();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === v) {
                if (structurizr.diagram.hasLinkHighlighted() && structurizr.diagram.isEditable()) {
                    structurizr.diagram.addVertex();
                    e.preventDefault();
                    return;
                }
            } else if (e.which === i) {
                showKey();
                return;
            } else if (e.which === p && !e.metaKey) {
                enterPresentationMode();
                return;
            } else if (e.which === t) {
                toggleTooltip();
                return;
            } else if (e.which === b) {
                back();
                return;
            } else if (e.which === l && structurizr.diagram.isEditable()) {
                openAutoLayoutModal();
                e.preventDefault();
                return;
            }
        });
    }

    function navigateToPreviousDiagram() {
        const currentView = structurizr.diagram.getCurrentViewOrFilter();

        var index = views.indexOf(currentView);
        if (index > 0) {
            window.location.hash = '#' + views[index-1].key;
        }
    }

    function navigateToNextDiagram() {
        const currentView = structurizr.diagram.getCurrentViewOrFilter();

        var index = views.indexOf(currentView);
        if (index < views.length -1) {
            window.location.hash = '#' + views[index+1].key;
        }
    }

    function diagramCreated() {
        var diagramIdentifier = '${diagramIdentifier}';

        if (window.location.hash) {
            const hash = window.location.hash;
            if (hash && hash.length > 1) {
                diagramIdentifier = decodeURIComponent(hash.substring(1)); // remove the # symbol
            }
        }

        if (!diagramIdentifier) {
            if (structurizr.diagram.isEditable()) {
                diagramIdentifier = structurizr.workspace.views.configuration.lastSavedView;
            } else {
                diagramIdentifier = structurizr.workspace.views.configuration.defaultView;
            }
            if (!diagramIdentifier) {
                diagramIdentifier = '';
            }
        }

        var view = structurizr.workspace.findViewByKey(diagramIdentifier);
        if (!view) {
            view = views[0];
        }

        if (view) {
            structurizr.diagram.changeView(view.key);
        }

        window.onhashchange = function () {
            if (window.location.hash) {
                var diagramIdentifier = window.location.hash;
                if (diagramIdentifier && diagramIdentifier.length > 1) {
                    diagramIdentifier = decodeURIComponent(diagramIdentifier.substring(1)); // remove the # symbol
                }

                var view = structurizr.workspace.findViewByKey(diagramIdentifier);
                if (view) {
                    progressMessage.show('<p>Rendering ' + structurizr.util.escapeHtml(structurizr.ui.getViewName(view)) + '</p><p style="font-size: 66%">(' + structurizr.util.escapeHtml(view.key) + ')</p>');

                    setTimeout(function() {
                        structurizr.diagram.changeView(view.key, function() {
                            progressMessage.hide();

                            <c:if test="${not empty iframe}">
                            postDiagramAspectRatioToParentWindow();
                            </c:if>

                            <c:if test="${embed eq true && empty iframe}">
                            postDiagramAspectRatioToParentWindow();
                            </c:if>
                        });
                    }, 10);
                }
            }
        };

        $(window).on("beforeunload", function() {
            if (structurizr.diagram.isEditable()) {
                if (unsavedChanges) {
                    return "There are unsaved changes to one or more diagrams in this workspace - diagram layout will be lost.";
                }
            }
        });

        document.getElementById('diagram-viewport').addEventListener('wheel', function(event) {
                if (event.ctrlKey === true) {
                    if (event.wheelDelta > 0) {
                        structurizr.diagram.zoomIn(event);
                    } else {
                        structurizr.diagram.zoomOut(event);
                    }

                    event.preventDefault();
                    event.stopPropagation();
                }
            },
            {
                passive: false
            });

        structurizr.scripting = new structurizr.scripting.DiagramScripting(structurizr.diagram);
    }

    function initQuickNavigation() {
        views.forEach(function(view) {
            const title = structurizr.util.escapeHtml(structurizr.ui.getViewName(view));
            quickNavigation.addItem(title + ' (#' + structurizr.util.escapeHtml(view.key) + ')', '${urlPrefix}/${quickNavigationPath}${urlSuffix}#' + structurizr.util.escapeHtml(view.key));
        });

        quickNavigation.onOpen(function() {
            structurizr.diagram.setKeyboardShortcutsEnabled(false);
        });
        quickNavigation.onClose(function() {
            structurizr.diagram.setKeyboardShortcutsEnabled(true);
        });
    }

    function createReview() {
        $('#reviewSelectedViewsButton').prop('disabled', false);
        $('#reviewViewList').val(structurizr.diagram.getCurrentViewOrFilter().key);
        $('#reviewModal').modal();
    }

    function elementDoubleClicked(evt, elementId) {
        const element = structurizr.workspace.findElementById(elementId);
        if (element) {
            if (evt.altKey === true && element.url !== undefined) {
                window.open(element.url);
                return;
            }

            var views = [];
            if (element.type === structurizr.constants.SOFTWARE_SYSTEM_ELEMENT_TYPE) {
                if (structurizr.diagram.getCurrentView().type === structurizr.constants.SYSTEM_LANDSCAPE_VIEW_TYPE || structurizr.diagram.getCurrentView().softwareSystemId !== element.id) {
                    views = structurizr.workspace.findSystemContextViewsForSoftwareSystem(element.id);
                    if (views.length === 0) {
                        views = structurizr.workspace.findContainerViewsForSoftwareSystem(element.id);
                    }
                } else if (structurizr.diagram.getCurrentView().type === structurizr.constants.SYSTEM_CONTEXT_VIEW_TYPE) {
                    views = structurizr.workspace.findContainerViewsForSoftwareSystem(element.id);
                }
            } else if (element.type === "Container") {
                views = structurizr.workspace.findComponentViewsForContainer(element.id);
            }

            if (views.length > 1) {
                openNavigationModal(views);
            } else if (views.length === 1) {
                window.location.hash = encodeURIComponent(views[0].key);
            } else if (element.url !== undefined) {
                window.open(element.url);
            }
        }
    }

    function relationshipDoubleClicked(evt, relationshipId) {
        const relationship = structurizr.workspace.findRelationshipById(relationshipId);
        if (relationship && relationship.url) {
            window.open(relationship.url);
        }
    }

    function isRendered() {
        return structurizr.diagram && structurizr.diagram.isRendered();
    }

    function isExportable() {
        return structurizr.diagram && structurizr.diagram.isExportable();
    }

    function saveWorkspace() {
        structurizr.workspace.views.configuration.lastSavedView = structurizr.diagram.getCurrentViewOrFilter().key;
        structurizr.saveWorkspace(false);

        $('#saveButton').prop('disabled', true);
        $('#saveButton').removeClass('btn-danger');
        unsavedChanges = false;

        refreshThumbnail();
    }

    function putImage(viewKey, filename, imageAsBase64EncodedDataUri, callback) {
        $.ajax({
            url: '/workspace/${workspace.id}/images/' + encodeURIComponent(filename),
            type: 'PUT',
            contentType: 'text/plain',
            cache: false,
            headers: {
                'Content-Type': 'text/plain'
            },
            dataType: 'json',
            data: imageAsBase64EncodedDataUri
        })
        .done(function(data, textStatus, jqXHR) {
            if (callback) {
                callback(viewKey);
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            // status[viewKey] = true;
            console.log(jqXHR);
            console.log(jqXHR.status);
            console.log("Text status: " + textStatus);
            console.log("Error thrown: " + errorThrown);

            if (callback) {
                callback(viewKey);
            }
        });
    }

    function openDocumentation() {
        openDocumentationOrDecisions('documentation', hasDocumentation);
    }

    function openDecisions() {
        openDocumentationOrDecisions('decisions', hasDecisions);
    }

    function openDocumentationOrDecisions(path, fn) {
        var view = structurizr.diagram.getCurrentView();
        var elementId;

        if (view.type === 'SystemContext' || view.type === 'Container') {
            elementId = view.softwareSystemId;
        } else if (view.type === 'Component') {
            elementId = view.containerId;
        } else if (view.type === 'Dynamic') {
            elementId = view.elementId;
        } else if (view.type === 'Deployment') {
            elementId = view.softwareSystemId;
        }

        if (elementId) {
            var element = structurizr.workspace.findElementById(elementId);
            if (element) {
                if (element.type === 'SoftwareSystem') {
                    var softwareSystem = element;

                    if (fn(softwareSystem)) {
                        window.location.href='${urlPrefix}/' + path + '/' + structurizr.util.escapeHtml(softwareSystem.name) + '${urlSuffix}';
                    } else {
                        window.location.href='${urlPrefix}/' + path + '${urlSuffix}';
                    }

                    return;
                } else if (element.type === 'Container') {
                    var container = element;
                    var softwareSystem = structurizr.workspace.findElementById(container.parentId);

                    if (fn(container)) {
                        window.location.href='${urlPrefix}/' + path + '/' + structurizr.util.escapeHtml(softwareSystem.name) + '/' + structurizr.util.escapeHtml(container.name) + '${urlSuffix}';
                    } else if (fn(softwareSystem)) {
                        window.location.href='${urlPrefix}/' + path + '/' + structurizr.util.escapeHtml(softwareSystem.name) + '${urlSuffix}';
                    } else {
                        window.location.href='${urlPrefix}/' + path + '${urlSuffix}';
                    }

                    return;
                }
            }
        }

        window.location.href='${urlPrefix}/' + path + '${urlSuffix}';
    }

    function hasDocumentation(element) {
        return element.documentation && element.documentation.sections && element.documentation.sections.length > 0;
    }

    function hasDecisions(element) {
        return element.documentation && element.documentation.decisions && element.documentation.decisions.length > 0;
    }

    <c:if test="${not empty iframe}">
    var diagramAspectRatio = undefined;
    var diagramControlsHeight = 0;

    function postDiagramAspectRatioToParentWindow(force) {
        if (diagramAspectRatio === undefined || force === true) {
            var canvasWidth = document.getElementById("diagram-canvas").offsetWidth;
            var canvasHeight = document.getElementById("diagram-canvas").offsetHeight;
            diagramAspectRatio = (canvasWidth / canvasHeight);
        }

        var diagramControls = document.getElementById("diagramControls");
        var controlsHeight = 0;
        if (diagramControls) {
            controlsHeight = diagramControls.offsetHeight;
        }
        if (diagramControlsHeight !== controlsHeight || force === true) {
            diagramControlsHeight = controlsHeight;

            parent.postMessage({
                iframe: '${iframe}',
                aspectRatio: diagramAspectRatio,
                controlsHeight: diagramControlsHeight,
                type: 'diagram',
                view: structurizr.diagram.getCurrentViewOrFilter().key
            }, '*');
        }
    }
    </c:if>

    <c:if test="${embed eq true && empty iframe}">
    function postDiagramAspectRatioToParentWindow() {
        var canvasHeight = document.getElementById("diagram-canvas").offsetHeight;

        window.parent.postMessage(JSON.stringify({
            src: window.location.toString(),
            context: 'iframe.resize',
            height: canvasHeight // pixels
        }), '*');
    }
    </c:if>

    $('#embeddedControls').hover(
        function() {
            $('#embeddedControls').css('opacity', '1.0');
        },
        function() {
            $('#embeddedControls').css('opacity', '0.1');
        }
    );

    $(window).resize(function() {
        if (structurizr.diagram) {
            structurizr.diagram.resize();
            structurizr.diagram.zoomToWidthOrHeight();

            <c:if test="${not empty iframe}">
            postDiagramAspectRatioToParentWindow();
            </c:if>

            <c:if test="${embed eq true && empty iframe}">
            postDiagramAspectRatioToParentWindow();
            </c:if>
        }
    });

    window.onorientationchange = function() {
        if (structurizr.diagram) {
            structurizr.diagram.resize();
            structurizr.diagram.zoomToWidthOrHeight();
        }
    };

    function enterPresentationMode() {
        presentationMode = true;

        if (!structurizr.ui.isFullScreen()) {
            structurizr.ui.enterFullScreen('diagram');
        }

        $('#diagramNavigationPanel').addClass('hidden');
        $('#enterPresentationModeButton').addClass('hidden');
        $('.structurizrDiagramViewport').css('background', '#000000');
        structurizr.diagram.resize();
        structurizr.diagram.zoomToWidthOrHeight();
    }

    function exitPresentationMode() {
        $('#enterPresentationModeButton').removeClass('hidden');
        $('.structurizrDiagramViewport').css('background', '');

        if (!structurizr.diagram.isEmbedded()) {
            $('#diagramNavigationPanel').removeClass('hidden');
        }

        presentationMode = false;
    }

    function toggleTooltip() {
        if (tooltip.isEnabled()) {
            tooltip.disable();
            $('.diagramTooltipOnButton').removeClass('hidden');
            $('.diagramTooltipOffButton').addClass('hidden');
        } else {
            tooltip.enable();
            $('.diagramTooltipOnButton').addClass('hidden');
            $('.diagramTooltipOffButton').removeClass('hidden');
        }
    }

    function getViewDropDown() {
        return $("#viewType");
    }

    function getPageSizeDropDown() {
        return $("#pageSize");
    }

    getViewDropDown().change(function() {
        var key = getViewDropDown().val();
        setTimeout(function() {
            window.location.hash = encodeURIComponent(key);
        }, 10);
    });

    getPageSizeDropDown().change(function() {
        var pageSize = getPageSizeDropDown().val();
        if (pageSize === 'none') {
            structurizr.diagram.getCurrentView().paperSize = undefined;
        } else {
            var dimensions = pageSize.split("x");
            structurizr.diagram.setPageSize(parseInt(dimensions[0]), parseInt(dimensions[1]));
            structurizr.diagram.getCurrentView().paperSize = $('#pageSize option:selected').attr('id');
        }
    });

    function animationStarted() {
        $('.stepBackwardAnimationButton').prop("disabled", false);
        $('.startAnimationButton').prop("disabled", true);
        $('.stopAnimationButton').prop("disabled", false);
    }

    function animationStopped() {
        $('.stepBackwardAnimationButton').prop("disabled", true);
        $('.startAnimationButton').prop("disabled", false);
        $('.stopAnimationButton').attr("disabled", true);
    }

    function startAnimation(autoPlay) {
        structurizr.diagram.startAnimation(autoPlay);
    }

    function stepBackwardInAnimation() {
        structurizr.diagram.stepBackwardInAnimation();
    }

    function stepForwardInAnimation() {
        structurizr.diagram.stepForwardInAnimation();
    }

    function stopAnimation() {
        structurizr.diagram.stopAnimation();
    }

    $(document).bind('webkitfullscreenchange mozfullscreenchange fullscreenchange fullscreenChange MSFullscreenChange',function(){
        if (structurizr.ui.isFullScreen()) {
            structurizr.diagram.resize();

            if (presentationMode) {
                structurizr.diagram.zoomToWidthOrHeight();
            }
        } else {
            if (presentationMode) {
                exitPresentationMode();
            }

            structurizr.diagram.resize();
            structurizr.diagram.zoomToWidthOrHeight();
        }
    });

    function toggleMultiSelectButtons(elements) {
        $('.multipleElementsSelectedButton').prop('disabled', elements.length < 2);
    }

    function showDiagramScope(bool) {
        if (bool) {
            $('#showDiagramScopeOnButton').addClass('hidden');
            $('#showDiagramScopeOffButton').removeClass('hidden');
            structurizr.diagram.showDiagramScope(true);
        } else {
            $('#showDiagramScopeOnButton').removeClass('hidden');
            $('#showDiagramScopeOffButton').addClass('hidden');
            structurizr.diagram.showDiagramScope(false);
        }
    }

</script>

<c:if test="${embed eq true}">
<script nonce="${scriptNonce}">
    quickNavigation.disable();
</script>
</c:if>

<c:choose>
    <c:when test="${loadWorkspaceFromParent eq true}">
<script nonce="${scriptNonce}">
    loadWorkspaceFromParent();
</script>
    </c:when>
    <c:when test="${not empty workspaceAsJson}">
<%@ include file="/WEB-INF/fragments/workspace/load-via-inline.jspf" %>
    </c:when>
    <c:otherwise>
<%@ include file="/WEB-INF/fragments/workspace/load-via-api.jspf" %>
    </c:otherwise>
</c:choose>

<c:if test="${structurizrConfiguration.type eq 'lite'}">
<%@ include file="/WEB-INF/fragments/workspace/auto-save.jspf" %>
<%@ include file="/WEB-INF/fragments/workspace/auto-refresh.jspf" %>
</c:if>