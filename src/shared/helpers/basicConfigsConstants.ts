export const appSystemTag = 'Notification-service Notiifications Service';
export const appTitle = 'Notification-service Notiifications Service';
export const appVersion = '0.0.1';
export const appPort = () => process.env.PORT || 3000;
export const appFavicon =
  'https://www.Notification-service.to/assets/logo_escrita-C57-kNgu.png';
export const appLogo =
  'https://www.Notification-service.to/assets/logo_escrita-C57-kNgu.png'; // TODO: add correct favicon
export const appDocPath = `/api/doc`;
export const appDocTitle = `${appTitle}`;
export const appDocDescription = `${appDocTitle} | Documentantion`;
export const appDocCustomCss = `
              .topbar-wrapper a > svg {  display: none; }
              .topbar-wrapper a { background-image: url('${appLogo}'); background-size: contain; background-repeat: no-repeat; height: 30px; width: 30px; }
              .swagger-ui .topbar { background-color: #4588E5; }
        `;
export const appDocUsername = () => process.env.USER_DOCS ?? 'doc';
export const appDocPassword = () => process.env.PASS_DOCS ?? 'password';
