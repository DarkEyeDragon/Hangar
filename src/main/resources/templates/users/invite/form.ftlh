<#import "/spring.ftl" as spring />
<#import "*/utils/hangar.ftlh" as hangar />
<#import "*/utils/userAvatar.ftlh" as userAvatar />
<#import "*/users/invite/userSearch.ftlh" as userSearch />
<#import "*/users/invite/roleSelect.ftlh" as roleSelect />

<#macro form owner roleCategory="" loadedUsers=[]>
<#-- @ftlvariable name="owner" type="io.papermc.hangar.db.model.UsersTable" -->
    <#-- Template row -->
    <table style="display: none;">
        <tbody>
        <tr id="result-row">
            <td>
                <input type="hidden"/>
                <@userAvatar.userAvatar clazz = "user-avatar-xs"/>
                <i class="fas fa-times user-cancel"></i>
                <a class="username" target="_blank" rel="noopener" href=""></a>
                <span><@roleSelect.roleSelect roleCategory=roleCategory /></span>
            </td>
        </tr>
        </tbody>
    </table>

<#-- User not found alert (hidden) -->
    <div class="alert alert-danger alert-dismissible" role="alert" style="display: none;">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <@spring.message "user.notFound" /> "<span class="error-username"></span>"
    </div>

    <div class="member-table-container">
        <table class="table table-members">
            <tbody>
            <#-- Owner (not submitted) -->
            <tr>
                <td>
                    <@userAvatar.userAvatar userName=owner.name avatarUrl=utils.avatarUrl(owner.name) clazz="user-avatar-xs" />
                    <#if owner.name?has_content>
                        <strong>${owner.name}</strong>
                    </#if>
                    <span><i class="minor"><@spring.message "project.owner" /></i></span>
                </td>
            </tr>

            <#list loadedUsers as user>
                <tr>
                    <td>
                        <input form="form-continue" type="hidden" value="${user.id}"/>
                        <@userAvatar.userAvatar userName=user.name avatarUrl=user.avatarUrl clazz="user-avatar-xs" />
                        <a target="_blank" rel="noopener" href="${Routes.USERS_SHOW_PROJECTS.getRouteUrl(user.name)}">
                            ${user.name}
                        </a>
                        <span><@roleSelect.roleSelect  roleCategory=roleCategory /></span>
                    </td>
                </tr>
            </#list>

            <#-- User search -->
            <tr>
                <td><@userSearch.userSearch /></td>
            </tr>

            </tbody>
        </table>
    </div>
</#macro>
