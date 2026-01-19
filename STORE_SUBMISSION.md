# MarketingTool App Store Submission Guide

## Android APK Location
The Android APK is ready at:
- Server path: `/var/www/marketingtool_app/build/app/outputs/flutter-apk/app-release.apk`
- Download URL: `https://marketingtool.pro/static/downloads/MarketingTool-v1.0.0.apk`

---

## Google Play Store Submission

### Step 1: Create a Google Play Developer Account
1. Go to https://play.google.com/console/
2. Pay the one-time $25 registration fee
3. Complete identity verification (may take 48 hours)

### Step 2: Create App Signing Key
Run these commands on the server:
```bash
cd /var/www/marketingtool_app
keytool -genkey -v -keystore android/app/marketingtool-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias marketingtool \
  -storepass YOUR_STORE_PASSWORD \
  -keypass YOUR_KEY_PASSWORD
```

### Step 3: Configure Signing
Create `/var/www/marketingtool_app/android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=marketingtool
storeFile=../app/marketingtool-release-key.jks
```

### Step 4: Build Signed App Bundle
```bash
cd /var/www/marketingtool_app
flutter build appbundle --release
```
The AAB file will be at: `build/app/outputs/bundle/release/app-release.aab`

### Step 5: Play Store Console Setup
1. Create a new app in Play Console
2. App name: `MarketingTool - AI Marketing Platform`
3. Default language: English (United States)
4. App category: Business > Marketing
5. Free or Paid: Free (with in-app purchases if applicable)

### Step 6: Store Listing Assets Required
- App icon: 512x512 PNG
- Feature graphic: 1024x500 PNG
- Phone screenshots: 2-8 images (16:9 or 9:16 ratio)
- 7-inch tablet screenshots: 1-8 images
- 10-inch tablet screenshots: 1-8 images
- Short description: Max 80 characters
- Full description: Max 4000 characters

### Step 7: Upload and Review
1. Upload the AAB file to Production or Internal Testing track
2. Complete all required sections (content rating, target audience, privacy policy)
3. Submit for review (typically 1-7 days)

---

## Apple App Store Submission

### Step 1: Apple Developer Account
1. Go to https://developer.apple.com/
2. Enroll in Apple Developer Program ($99/year)
3. Wait for approval (up to 48 hours)

### Step 2: Setup Codemagic (Cloud Build)
Since iOS builds require macOS, use Codemagic:

1. Go to https://codemagic.io/
2. Sign up and connect your repository
3. Import the project from: `/var/www/marketingtool_app`
4. The `codemagic.yaml` is already configured

### Step 3: Configure Apple App Store Connect
1. Go to https://appstoreconnect.apple.com/
2. Create a new app:
   - Platform: iOS
   - Name: MarketingTool
   - Bundle ID: pro.marketingtool.app
   - SKU: marketingtool-001
   - Primary Language: English (US)

### Step 4: Connect Codemagic to App Store Connect
1. In Codemagic, go to Teams > Integrations
2. Add App Store Connect API key
3. Go to App Store Connect > Users and Access > Keys
4. Create a new key with Admin access
5. Download the .p8 file and add to Codemagic

### Step 5: Configure Code Signing
1. In Codemagic, enable automatic code signing
2. Codemagic will manage certificates and provisioning profiles

### Step 6: Build and Publish
1. Trigger a build in Codemagic
2. Select ios-workflow
3. Codemagic will build and upload to TestFlight automatically

### Step 7: App Store Listing Assets Required
- App icon: 1024x1024 PNG (no alpha, no rounded corners)
- Screenshots:
  - iPhone 6.5" display: 1284x2778 or 1242x2688
  - iPhone 5.5" display: 1242x2208
  - iPad Pro 12.9" display: 2048x2732
- Preview video (optional): 15-30 seconds
- Description: Max 4000 characters
- Promotional text: Max 170 characters
- Keywords: Max 100 characters

---

## App Information

**Package Names:**
- Android: `pro.marketingtool.app`
- iOS: `pro.marketingtool.app`

**Required Store Listing Content:**

### Short Description (80 chars)
AI-powered marketing tools for ads, content, SEO, and analytics automation.

### Full Description
MarketingTool is your all-in-one AI marketing platform that helps businesses create, manage, and optimize their digital marketing campaigns.

Key Features:
- AI Marketing Agents - Automated campaign management
- E-commerce & Shopify Tools - Boost your online sales
- Analytics Platform - Real-time insights and reporting
- Content Writing Tools - AI-powered copywriting
- Creative & Ads Tools - Design stunning ad creatives
- SEO Tools - Improve your search rankings
- PPC & Optimization Tools - Maximize your ad spend

Start with a 7-day free trial and unlock the power of AI marketing!

### Privacy Policy URL
https://marketingtool.pro/privacy-policy/

### Support Email
help@marketingtool.pro

### Website
https://marketingtool.pro

---

## Next Steps

1. [ ] Create Google Play Developer account
2. [ ] Create Apple Developer account  
3. [ ] Generate Android signing key
4. [ ] Build signed App Bundle (.aab)
5. [ ] Upload to Play Store
6. [ ] Setup Codemagic account
7. [ ] Connect Codemagic to App Store Connect
8. [ ] Trigger iOS build
9. [ ] Complete store listings
10. [ ] Submit for review
