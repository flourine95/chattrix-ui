# Web Platform Configuration for Agora Video/Audio Calls

## Browser Permissions

The web platform requires explicit user permission for camera and microphone access. The permissions are requested through the browser's native permission API.

### Supported Browsers

Agora Web SDK supports:
- Chrome 58+
- Firefox 56+
- Safari 11+
- Edge 80+

### HTTPS Requirement

**Important**: Camera and microphone access in browsers requires HTTPS. The application will not work with HTTP in production.

For local development:
- `flutter run -d chrome` uses localhost which is allowed
- For testing on other devices, use HTTPS or configure browser flags (not recommended for production)

### Permissions Policy

The `index.html` includes a Permissions-Policy meta tag that allows camera, microphone, and display capture:

```html
<meta http-equiv="Permissions-Policy" content="camera=*, microphone=*, display-capture=*">
```

### Browser-Specific Notes

#### Chrome/Edge
- Permissions are persistent after first grant
- Users can manage permissions via site settings

#### Firefox
- Permissions may need to be granted per session
- Check browser console for permission errors

#### Safari
- Stricter permission policies
- May require user interaction before requesting permissions
- Test thoroughly on Safari/iOS Safari

### Testing Permissions

To test permission handling:

1. **Grant Permissions**: Accept camera/microphone when prompted
2. **Deny Permissions**: Reject and verify error handling shows permission dialog
3. **Revoke Permissions**: Use browser settings to revoke and test re-request flow

### Troubleshooting

**Permission Denied Errors**:
- Ensure HTTPS is used (or localhost for development)
- Check browser console for specific error messages
- Verify Permissions-Policy meta tag is present
- Check if browser has blocked the site from accessing media

**No Permission Prompt**:
- Browser may have remembered a previous "deny" decision
- Clear site data and reload
- Check browser's site settings

**Agora Connection Issues**:
- Verify network connectivity
- Check if firewall/proxy is blocking WebRTC
- Ensure Agora App ID and tokens are valid
- Check browser console for Agora SDK errors

### Deployment Checklist

- [ ] Ensure application is served over HTTPS
- [ ] Test on all target browsers
- [ ] Verify permission prompts appear correctly
- [ ] Test permission denial flow
- [ ] Verify video/audio quality
- [ ] Test network quality indicators
- [ ] Verify call end cleanup

### Additional Resources

- [Agora Web SDK Documentation](https://docs.agora.io/en/video-calling/get-started/get-started-sdk)
- [Browser Media Permissions](https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia)
- [WebRTC Browser Support](https://caniuse.com/rtcpeerconnection)
