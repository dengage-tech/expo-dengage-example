package com.dengage.expodengageexample
import com.dengagetech.reactnativedengage.DengageRNCoordinator

import android.app.Application
import android.content.res.Configuration

import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactNativeApplicationEntryPoint.loadReactNative
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.react.ReactHost
import com.facebook.react.common.ReleaseLevel
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint
import com.facebook.react.defaults.DefaultReactNativeHost

import expo.modules.ApplicationLifecycleDispatcher
import expo.modules.ReactNativeHostWrapper

class MainApplication : Application(), ReactApplication {

  override val reactNativeHost: ReactNativeHost = ReactNativeHostWrapper(
      this,
      object : DefaultReactNativeHost(this) {
        override fun getPackages(): List<ReactPackage> =
            PackageList(this).packages.apply {
              // Packages that cannot be autolinked yet can be added manually here, for example:
              // add(MyReactNativePackage())
            }

          override fun getJSMainModuleName(): String = ".expo/.virtual-metro-entry"

          override fun getUseDeveloperSupport(): Boolean = BuildConfig.DEBUG

          override val isNewArchEnabled: Boolean = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
      }
  )

  override val reactHost: ReactHost
    get() = ReactNativeHostWrapper.createReactHost(applicationContext, reactNativeHost)

  override fun onCreate() {
    super.onCreate()
    DefaultNewArchitectureEntryPoint.releaseLevel = try {
      ReleaseLevel.valueOf(BuildConfig.REACT_NATIVE_RELEASE_LEVEL.uppercase())
    } catch (e: IllegalArgumentException) {
      ReleaseLevel.STABLE
    }
    loadReactNative(this)
    ApplicationLifecycleDispatcher.onApplicationCreate(this)
// @generated begin @dengage-tech/expo-dengage
    DengageRNCoordinator.sharedInstance.injectReactInstanceManager(reactNativeHost.reactInstanceManager)
    DengageRNCoordinator.sharedInstance.setupDengage(
      firebaseIntegrationKey = "YtPEpvwpighOnJArUIheeFtIA0pTQcFJzyqIPdvs7cjBYSUH4kZb5w_s_l_BXGByP_p_l_EqSTv4AwsYpWNz_s_l_b3VCwRhSkQUyQlQzjyCk8qox8sXtyvCsQMRozVQErjvCKTxLUcc02Jfodw4Nk7uCixW1Lw74Q_e_q__e_q_",
      huaweiIntegrationKey = null,
      context = this,
      dengageHmsManager = null,
      deviceConfigurationPreference = com.dengage.sdk.data.remote.api.DeviceConfigurationPreference.Google,
      disableOpenWebUrl = false,
      logEnabled = true,
      enableGeoFence = true,
      developmentStatus = BuildConfig.DEBUG
    )
// @generated end @dengage-tech/expo-dengage
  }

  override fun onConfigurationChanged(newConfig: Configuration) {
    super.onConfigurationChanged(newConfig)
    ApplicationLifecycleDispatcher.onConfigurationChanged(this, newConfig)
  }
}
