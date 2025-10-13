-- CreateEnum
CREATE TYPE "ApplicationVersionStatus" AS ENUM ('DEVELOPMENT', 'STAGING', 'PRODUCTION');

-- CreateEnum
CREATE TYPE "TypeLog" AS ENUM ('ERROR', 'WARNING', 'INFO');

-- CreateEnum
CREATE TYPE "TypeNotification" AS ENUM ('EMAIL', 'SMS', 'PUSH', 'DISCORD', 'SLACK', 'IN_APP');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('PENDING', 'SENT', 'FAILED', 'CANCELED', 'RE_SCHEDULED', 'ScHEDULED');

-- CreateTable
CREATE TABLE "notification_applications" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "api_key" TEXT NOT NULL,
    "version_status" "ApplicationVersionStatus" NOT NULL,
    "refresh_api_key" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notification_applications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notification_notifications" (
    "id" TEXT NOT NULL,
    "type" "TypeNotification" NOT NULL,
    "receipts" TEXT[],
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "scheduled_at" TIMESTAMP(3),
    "sendt_at" TIMESTAMP(3),
    "application_id" TEXT NOT NULL,
    "re_scheduled_at" TIMESTAMP(3),
    "status" "NotificationStatus" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notification_notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notification_logs" (
    "id" TEXT NOT NULL,
    "error" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "type" "TypeLog" NOT NULL,
    "status_code" INTEGER,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "retry_count" INTEGER,
    "notification_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notification_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminPages" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "page" VARCHAR NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PK_admin_page" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "City" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "codeIbge" INTEGER,
    "stateId" INTEGER,
    "population" INTEGER,
    "density" INTEGER,
    "gentle" VARCHAR(255),
    "area" INTEGER,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" SERIAL NOT NULL,
    "headquarterId" INTEGER,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "trandingName" VARCHAR(255) NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 1,
    "cnpj" VARCHAR(255),
    "zipCode" VARCHAR(255),
    "address" VARCHAR(255),
    "number" VARCHAR(255),
    "complement" VARCHAR(255),
    "state" VARCHAR(255),
    "district" VARCHAR(255),
    "cityId" INTEGER,
    "phone" VARCHAR(255),
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "responsible" INTEGER,
    "rulesId" UUID,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyAdminPages" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "companyId" INTEGER NOT NULL,
    "adminPageId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PK_company_admin_page" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyDomains" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "companyId" INTEGER NOT NULL,
    "domain" VARCHAR NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pk_company_domains_id" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyRules" (
    "id" UUID NOT NULL,
    "modalities" VARCHAR[],
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "adminReadOnly" BOOLEAN DEFAULT true,
    "adminLooker" VARCHAR,
    "adminLookerSales" VARCHAR,
    "estimateLimit" SMALLINT,
    "estimatePlayerLimit" SMALLINT,

    CONSTRAINT "CompanyRules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contacts" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(255),
    "cellphone" VARCHAR(255),
    "phone" VARCHAR(255),
    "email" VARCHAR(255),
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Contacts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostCentre" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "responsible" INTEGER,
    "cdcParent" INTEGER,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "principal" BOOLEAN NOT NULL,
    "status" INTEGER NOT NULL,
    "priceLimit" VARCHAR(255) NOT NULL,
    "totalRides" VARCHAR(255) NOT NULL,
    "projectEnable" BOOLEAN NOT NULL,
    "justifyEnable" BOOLEAN NOT NULL,
    "behavior" VARCHAR(255) NOT NULL,
    "exceptionValue" VARCHAR(255) NOT NULL,
    "notificationType" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CostCentre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostCentreJustify" (
    "id" SERIAL NOT NULL,
    "costCentreId" INTEGER NOT NULL,
    "justifyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CostCentreJustify_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostCentrePolicy" (
    "id" SERIAL NOT NULL,
    "costCentreId" INTEGER NOT NULL,
    "policyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CostCentrePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostCentreProject" (
    "id" SERIAL NOT NULL,
    "costCentreId" INTEGER,
    "projectId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "CostCentreProject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorites" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "placeId" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "shortAddress" VARCHAR(255) NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "lastAccess" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "district" VARCHAR,
    "city" VARCHAR,
    "state" VARCHAR,
    "zipcode" VARCHAR,

    CONSTRAINT "Favorites_PK" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Justify" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "description" VARCHAR(255),
    "status" INTEGER,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Justify_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Policy" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(255),
    "rules" JSON,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,
    "description" VARCHAR(255),

    CONSTRAINT "Policy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(255),
    "description" VARCHAR(255),
    "status" INTEGER,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RoleCompany" (
    "id" SERIAL NOT NULL,
    "roleId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "RoleCompany_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RolePolicy" (
    "id" SERIAL NOT NULL,
    "roleId" INTEGER NOT NULL,
    "policyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "RolePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Roles" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SelfRegisterLog" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "error" VARCHAR,

    CONSTRAINT "SelfRegisterLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SequelizeMeta" (
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "State" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "initials" VARCHAR(255),
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "State_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripeeMobCompany" (
    "id" SERIAL NOT NULL,
    "tripeeCompanyId" INTEGER NOT NULL,
    "mobCompanyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "TripeeMobCompany_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripeeMobCostCentre" (
    "id" SERIAL NOT NULL,
    "tripeeCostCentreId" INTEGER NOT NULL,
    "mobCostCentreId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "TripeeMobCostCentre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripeeMobJustify" (
    "id" SERIAL NOT NULL,
    "tripeeJustifyId" INTEGER NOT NULL,
    "mobJustifyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "TripeeMobJustify_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripeeMobProject" (
    "id" SERIAL NOT NULL,
    "tripeeProjectId" INTEGER NOT NULL,
    "mobProjectId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "TripeeMobProject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TripeeMobUser" (
    "id" SERIAL NOT NULL,
    "tripeeUserId" INTEGER NOT NULL,
    "mobUserId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "TripeeMobUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "PolicyId" INTEGER,
    "supervisorId" INTEGER,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255),
    "cellphone" VARCHAR(255),
    "externalId" VARCHAR(255),
    "cpf" VARCHAR(255),
    "occupation" VARCHAR(255),
    "status" INTEGER,
    "role" INTEGER,
    "firstAccessAt" TIMESTAMPTZ(6),
    "LastAccessAt" TIMESTAMPTZ(6),
    "resetPasswordAt" TIMESTAMPTZ(6),
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "firebase_token" VARCHAR,
    "resetPassword" BOOLEAN NOT NULL DEFAULT false,
    "prioritized_user" BOOLEAN DEFAULT false,
    "request_third_party" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAdminPages" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "userId" INTEGER NOT NULL,
    "adminPageId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PK_user_admin_page" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCostCentre" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "costCentreId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "UserCostCentre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserTripeeAdmin" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "email" VARCHAR NOT NULL,

    CONSTRAINT "UserTripeeAdmin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedback" (
    "id" SERIAL NOT NULL,
    "message" VARCHAR(1000) NOT NULL,
    "subject" VARCHAR(150) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "platform" VARCHAR(1000) NOT NULL,
    "platform_version" VARCHAR(1000) NOT NULL,
    "app_version" VARCHAR(1000) NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "feedback_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "loft_access_control" (
    "id" SERIAL NOT NULL,
    "codigo" VARCHAR(255) NOT NULL,
    "hora" VARCHAR(255),
    "nome_do_usuario" VARCHAR(255),
    "cpf" VARCHAR(255),
    "grupo" VARCHAR(255),
    "empresa" VARCHAR(255),
    "departamento" VARCHAR(255),
    "empresa_visitada" VARCHAR(255),
    "autorizacao" VARCHAR(255),
    "detalhes" VARCHAR(255),
    "matricula" VARCHAR(255),
    "dispositivo" VARCHAR(255),
    "area" VARCHAR(255),
    "operador" VARCHAR(255),

    CONSTRAINT "pk_loft_access_control" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "loft_access_control_guest" (
    "id" SERIAL NOT NULL,
    "entry_id" BIGINT,
    "name" VARCHAR(255),
    "company_name" VARCHAR(255),
    "location_name" VARCHAR(255),
    "email" VARCHAR(255),
    "entry_approval_status" VARCHAR(255),
    "flow_name" VARCHAR(255),
    "invite_status" VARCHAR(255),
    "private_notes" VARCHAR(255),
    "group_name" VARCHAR(255),
    "host" VARCHAR(255),
    "location_timezone" VARCHAR(255),
    "sign_in_time" TIMESTAMPTZ(6),
    "legal_docs" VARCHAR(255),
    "sign_out_time" TIMESTAMPTZ(6),
    "security" VARCHAR(255),
    "phone_number" VARCHAR(255),
    "desk" VARCHAR(255),
    "floor" VARCHAR(255),
    "neighborhood" VARCHAR(255),
    "empresa" VARCHAR(255),
    "falar_com" VARCHAR(255),
    "falar_com_2" VARCHAR(255),
    "rg" VARCHAR(255),
    "rg_2" VARCHAR(255),

    CONSTRAINT "pk_loft_access_control_guest" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "loft_users" (
    "id" SERIAL NOT NULL,
    "empresa" VARCHAR(255) NOT NULL,
    "matricula" VARCHAR(255),
    "nome" VARCHAR(255),
    "cpf" VARCHAR(255),
    "email" VARCHAR(255),
    "area" VARCHAR(255),
    "subarea" VARCHAR(255),
    "alocacao" VARCHAR(255),
    "lider" VARCHAR(255),
    "execao_tech" VARCHAR(255),
    "escritorio" VARCHAR(255),
    "empresa_new" VARCHAR,
    "matricula_new" VARCHAR,
    "nome_new" VARCHAR,
    "cpf_new" VARCHAR,
    "area_new" VARCHAR,
    "subarea_new" VARCHAR,
    "alocacao_new" VARCHAR,
    "cdc" VARCHAR,
    "segmentacao" VARCHAR,

    CONSTRAINT "pk_loft_users" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "notification_applications_api_key_key" ON "notification_applications"("api_key");

-- CreateIndex
CREATE INDEX "idx_app_name" ON "notification_applications"("name");

-- CreateIndex
CREATE INDEX "idx_app_api_key" ON "notification_applications"("api_key");

-- CreateIndex
CREATE INDEX "idx_notification_application_id" ON "notification_notifications"("application_id");

-- CreateIndex
CREATE INDEX "idx_notification_type" ON "notification_notifications"("type");

-- CreateIndex
CREATE INDEX "idx_notification_status" ON "notification_notifications"("status");

-- CreateIndex
CREATE INDEX "idx_log_notification_id" ON "notification_logs"("notification_id");

-- CreateIndex
CREATE INDEX "idx_log_type" ON "notification_logs"("type");

-- CreateIndex
CREATE INDEX "idx_log_status_code" ON "notification_logs"("status_code");

-- CreateIndex
CREATE UNIQUE INDEX "Company_name_key" ON "Company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Company_trandingName_key" ON "Company"("trandingName");

-- CreateIndex
CREATE UNIQUE INDEX "SelfRegisterLog_userid_key" ON "SelfRegisterLog"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "State_name_key" ON "State"("name");

-- CreateIndex
CREATE UNIQUE INDEX "uq_tripeemobuser_tripeeuserid" ON "TripeeMobUser"("tripeeUserId");

-- CreateIndex
CREATE UNIQUE INDEX "uq_tripeemobuser_mobuserid" ON "TripeeMobUser"("mobUserId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserAdminPages_userId_adminPageId_key" ON "UserAdminPages"("userId", "adminPageId");

-- CreateIndex
CREATE UNIQUE INDEX "UserTripeeAdmin_email_key" ON "UserTripeeAdmin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "uq_loft_users_email" ON "loft_users"("email");

-- AddForeignKey
ALTER TABLE "notification_notifications" ADD CONSTRAINT "notification_notifications_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "notification_applications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notification_logs" ADD CONSTRAINT "notification_logs_notification_id_fkey" FOREIGN KEY ("notification_id") REFERENCES "notification_notifications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "City" ADD CONSTRAINT "City_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "State"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_headquarter_fkey" FOREIGN KEY ("headquarterId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_responsible_fkey" FOREIGN KEY ("responsible") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_rulesId_fkey" FOREIGN KEY ("rulesId") REFERENCES "CompanyRules"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "CompanyAdminPages" ADD CONSTRAINT "FK_company_admin_page_admin_page_id" FOREIGN KEY ("adminPageId") REFERENCES "AdminPages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "CompanyAdminPages" ADD CONSTRAINT "FK_company_admin_page_company_id" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "CompanyDomains" ADD CONSTRAINT "fk_company_domains_company_id" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Contacts" ADD CONSTRAINT "Contacts_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentre" ADD CONSTRAINT "CostCentre_cdcParent_fkey" FOREIGN KEY ("cdcParent") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentre" ADD CONSTRAINT "CostCentre_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentre" ADD CONSTRAINT "CostCentre_responsible_fkey" FOREIGN KEY ("responsible") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentreJustify" ADD CONSTRAINT "CostCentreJustify_costCentreId_fkey" FOREIGN KEY ("costCentreId") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentreJustify" ADD CONSTRAINT "CostCentreJustify_justifyId_fkey" FOREIGN KEY ("justifyId") REFERENCES "Justify"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentrePolicy" ADD CONSTRAINT "CostCentrePolicy_costCentreId_fkey" FOREIGN KEY ("costCentreId") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentrePolicy" ADD CONSTRAINT "CostCentrePolicy_policyId_fkey" FOREIGN KEY ("policyId") REFERENCES "Policy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentreProject" ADD CONSTRAINT "CostCentreProject_costCentreId_fkey" FOREIGN KEY ("costCentreId") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostCentreProject" ADD CONSTRAINT "CostCentreProject_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_User_FK" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Justify" ADD CONSTRAINT "Justify_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Policy" ADD CONSTRAINT "Policy_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoleCompany" ADD CONSTRAINT "RoleCompany_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoleCompany" ADD CONSTRAINT "RoleCompany_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePolicy" ADD CONSTRAINT "RolePolicy_policyId_fkey" FOREIGN KEY ("policyId") REFERENCES "Policy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RolePolicy" ADD CONSTRAINT "RolePolicy_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SelfRegisterLog" ADD CONSTRAINT "SelfRegisterLog_id_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TripeeMobCompany" ADD CONSTRAINT "TripeeMobCompany_tripeeCompanyId_fkey" FOREIGN KEY ("tripeeCompanyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripeeMobCostCentre" ADD CONSTRAINT "TripeeMobCostCentre_tripeeCostCentreId_fkey" FOREIGN KEY ("tripeeCostCentreId") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripeeMobJustify" ADD CONSTRAINT "TripeeMobJustify_tripeeJustifyId_fkey" FOREIGN KEY ("tripeeJustifyId") REFERENCES "Justify"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripeeMobProject" ADD CONSTRAINT "TripeeMobProject_tripeeProjectId_fkey" FOREIGN KEY ("tripeeProjectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TripeeMobUser" ADD CONSTRAINT "TripeeMobUser_tripeeUserId_fkey" FOREIGN KEY ("tripeeUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_PolicyId_fkey" FOREIGN KEY ("PolicyId") REFERENCES "Policy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_fkey" FOREIGN KEY ("role") REFERENCES "Roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_supervisorId_fkey" FOREIGN KEY ("supervisorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAdminPages" ADD CONSTRAINT "FK_user_admin_page_admin_page_id" FOREIGN KEY ("adminPageId") REFERENCES "AdminPages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "UserAdminPages" ADD CONSTRAINT "FK_user_admin_page_user_id" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "UserCostCentre" ADD CONSTRAINT "UserCostCentre_costCentreId_fkey" FOREIGN KEY ("costCentreId") REFERENCES "CostCentre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCostCentre" ADD CONSTRAINT "UserCostCentre_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback" ADD CONSTRAINT "feedback_fk" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

