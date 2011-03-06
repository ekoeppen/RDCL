require "rdcl/link/dock_cmds/dock_cmd.rb"
require "rdcl/link/dock_cmds/dock_cmd_added_id.rb"
require "rdcl/link/dock_cmds/dock_cmd_add_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_add_entry_with_unique_id.rb"
require "rdcl/link/dock_cmds/dock_cmd_alias_resolved.rb"
require "rdcl/link/dock_cmds/dock_cmd_app_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_backup_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_backup_packages.rb"
require "rdcl/link/dock_cmds/dock_cmd_backup_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_backup_soup_done.rb"
require "rdcl/link/dock_cmds/dock_cmd_call_global_function.rb"
require "rdcl/link/dock_cmds/dock_cmd_call_result.rb"
require "rdcl/link/dock_cmds/dock_cmd_call_root_method.rb"
require "rdcl/link/dock_cmds/dock_cmd_changed_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_changed_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_create_default_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_create_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_current_time.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_count_entries.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_free.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_goto_key.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_map.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_move.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_next.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_prev.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_reset.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_reset_to_end.rb"
require "rdcl/link/dock_cmds/dock_cmd_cursor_which_end.rb"
require "rdcl/link/dock_cmds/dock_cmd_default_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_delete_all_packages.rb"
require "rdcl/link/dock_cmds/dock_cmd_delete_entries.rb"
require "rdcl/link/dock_cmds/dock_cmd_delete_pkg_dir.rb"
require "rdcl/link/dock_cmds/dock_cmd_delete_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_desktop_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_devices.rb"
require "rdcl/link/dock_cmds/dock_cmd_disconnect.rb"
require "rdcl/link/dock_cmds/dock_cmd_empty_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_factory.rb"
require "rdcl/link/dock_cmds/dock_cmd_files_and_folders.rb"
require "rdcl/link/dock_cmds/dock_cmd_file_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_filters.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_app_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_changed_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_changed_index.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_changed_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_default_path.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_default_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_devices.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_files_and_folders.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_file_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_filters.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_index_description.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_inheritance.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_internal_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_package_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_package_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_password.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_patches.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_restore_options.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_soup_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_soup_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_soup_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_store_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_get_sync_options.rb"
require "rdcl/link/dock_cmds/dock_cmd_hello.rb"
require "rdcl/link/dock_cmds/dock_cmd_importing.rb"
require "rdcl/link/dock_cmds/dock_cmd_import_file.rb"
require "rdcl/link/dock_cmds/dock_cmd_import_parameters_slip.rb"
require "rdcl/link/dock_cmds/dock_cmd_import_parameter_slip_result.rb"
require "rdcl/link/dock_cmds/dock_cmd_index_description.rb"
require "rdcl/link/dock_cmds/dock_cmd_inheritance.rb"
require "rdcl/link/dock_cmds/dock_cmd_initiate_docking.rb"
require "rdcl/link/dock_cmds/dock_cmd_internal_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_keyboard_char.rb"
require "rdcl/link/dock_cmds/dock_cmd_keyboard_string.rb"
require "rdcl/link/dock_cmds/dock_cmd_last_sync_time.rb"
require "rdcl/link/dock_cmds/dock_cmd_load_package.rb"
require "rdcl/link/dock_cmds/dock_cmd_load_package_file.rb"
require "rdcl/link/dock_cmds/dock_cmd_long_data.rb"
require "rdcl/link/dock_cmds/dock_cmd_newton_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_newton_name.rb"
require "rdcl/link/dock_cmds/dock_cmd_operation_canceled.rb"
require "rdcl/link/dock_cmds/dock_cmd_operation_done.rb"
require "rdcl/link/dock_cmds/dock_cmd_op_canceled_ack.rb"
require "rdcl/link/dock_cmds/dock_cmd_package.rb"
require "rdcl/link/dock_cmds/dock_cmd_package_idlist.rb"
require "rdcl/link/dock_cmds/dock_cmd_package_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_password.rb"
require "rdcl/link/dock_cmds/dock_cmd_patches.rb"
require "rdcl/link/dock_cmds/dock_cmd_path.rb"
require "rdcl/link/dock_cmds/dock_cmd_query.rb"
require "rdcl/link/dock_cmds/dock_cmd_ref_result.rb"
require "rdcl/link/dock_cmds/dock_cmd_ref_test.rb"
require "rdcl/link/dock_cmds/dock_cmd_reg_protocol_extension.rb"
require "rdcl/link/dock_cmds/dock_cmd_remove_package.rb"
require "rdcl/link/dock_cmds/dock_cmd_remove_protocol_extension.rb"
require "rdcl/link/dock_cmds/dock_cmd_request_to_browse.rb"
require "rdcl/link/dock_cmds/dock_cmd_request_to_dock.rb"
require "rdcl/link/dock_cmds/dock_cmd_request_to_install.rb"
require "rdcl/link/dock_cmds/dock_cmd_request_to_restore.rb"
require "rdcl/link/dock_cmds/dock_cmd_request_to_sync.rb"
require "rdcl/link/dock_cmds/dock_cmd_resolve_alias.rb"
require "rdcl/link/dock_cmds/dock_cmd_restore_all.rb"
require "rdcl/link/dock_cmds/dock_cmd_restore_file.rb"
require "rdcl/link/dock_cmds/dock_cmd_restore_options.rb"
require "rdcl/link/dock_cmds/dock_cmd_restore_package.rb"
require "rdcl/link/dock_cmds/dock_cmd_restore_patch.rb"
require "rdcl/link/dock_cmds/dock_cmd_result.rb"
require "rdcl/link/dock_cmds/dock_cmd_result_string.rb"
require "rdcl/link/dock_cmds/dock_cmd_return_changed_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_return_entry.rb"
require "rdcl/link/dock_cmds/dock_cmd_send_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_base_id.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_current_soup.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_current_store.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_drive.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_filter.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_path.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_soup_get_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_soup_signature.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_store_get_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_store_name.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_store_signature.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_store_to_default.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_timeout.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_translator.rb"
require "rdcl/link/dock_cmds/dock_cmd_set_vbocompression.rb"
require "rdcl/link/dock_cmds/dock_cmd_soups_changed.rb"
require "rdcl/link/dock_cmds/dock_cmd_soup_ids.rb"
require "rdcl/link/dock_cmds/dock_cmd_soup_info.rb"
require "rdcl/link/dock_cmds/dock_cmd_soup_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_soup_not_dirty.rb"
require "rdcl/link/dock_cmds/dock_cmd_source_version.rb"
require "rdcl/link/dock_cmds/dock_cmd_start_keyboard_passthrough.rb"
require "rdcl/link/dock_cmds/dock_cmd_store_names.rb"
require "rdcl/link/dock_cmds/dock_cmd_synchronize.rb"
require "rdcl/link/dock_cmds/dock_cmd_sync_options.rb"
require "rdcl/link/dock_cmds/dock_cmd_sync_results.rb"
require "rdcl/link/dock_cmds/dock_cmd_test.rb"
require "rdcl/link/dock_cmds/dock_cmd_translator_list.rb"
require "rdcl/link/dock_cmds/dock_cmd_unknown_command.rb"
require "rdcl/link/dock_cmds/dock_cmd_unknown_dsnc.rb"
require "rdcl/link/dock_cmds/dock_cmd_which_icons.rb"

module RDCL
  
  class DockCmdFactory
    
    COMMAND_MAP = [
      [DockCmd::LONG_DATA, :DockCmdLongData],
      [DockCmd::REF_RESULT, :DockCmdRefResult],
      [DockCmd::QUERY, :DockCmdQuery],
      [DockCmd::CURSOR_GOTO_KEY, :DockCmdCursorGotoKey],
      [DockCmd::CURSOR_MAP, :DockCmdCursorMap],
      [DockCmd::CURSOR_ENTRY, :DockCmdCursorEntry],
      [DockCmd::CURSOR_MOVE, :DockCmdCursorMove],
      [DockCmd::CURSOR_NEXT, :DockCmdCursorNext],
      [DockCmd::CURSOR_PREV, :DockCmdCursorPrev],
      [DockCmd::CURSOR_RESET, :DockCmdCursorReset],
      [DockCmd::CURSOR_RESET_TO_END, :DockCmdCursorResetToEnd],
      [DockCmd::CURSOR_COUNT_ENTRIES, :DockCmdCursorCountEntries],
      [DockCmd::CURSOR_WHICH_END, :DockCmdCursorWhichEnd],
      [DockCmd::CURSOR_FREE, :DockCmdCursorFree],
      [DockCmd::KEYBOARD_CHAR, :DockCmdKeyboardChar],
      [DockCmd::KEYBOARD_STRING, :DockCmdKeyboardString],
      [DockCmd::START_KEYBOARD_PASSTHROUGH, :DockCmdStartKeyboardPassthrough],
      [DockCmd::DEFAULT_STORE, :DockCmdDefaultStore],
      [DockCmd::APP_NAMES, :DockCmdAppNames],
      [DockCmd::IMPORT_PARAMETER_SLIP_RESULT, :DockCmdImportParameterSlipResult],
      [DockCmd::PACKAGE_INFO, :DockCmdPackageInfo],
      [DockCmd::SET_BASE_ID, :DockCmdSetBaseID],
      [DockCmd::BACKUP_IDS, :DockCmdBackupIDs],
      [DockCmd::BACKUP_SOUP_DONE, :DockCmdBackupSoupDone],
      [DockCmd::SOUP_NOT_DIRTY, :DockCmdSoupNotDirty],
      [DockCmd::SYNCHRONIZE, :DockCmdSynchronize],
      [DockCmd::CALL_RESULT, :DockCmdCallResult],
      [DockCmd::REMOVE_PACKAGE, :DockCmdRemovePackage],
      [DockCmd::RESULT_STRING, :DockCmdResultString],
      [DockCmd::SOURCE_VERSION, :DockCmdSourceVersion],
      [DockCmd::ADD_ENTRY_WITH_UNIQUE_ID, :DockCmdAddEntryWithUniqueID],
      [DockCmd::GET_PACKAGE_INFO, :DockCmdGetPackageInfo],
      [DockCmd::GET_DEFAULT_STORE, :DockCmdGetDefaultStore],
      [DockCmd::CREATE_DEFAULT_SOUP, :DockCmdCreateDefaultSoup],
      [DockCmd::GET_APP_NAMES, :DockCmdGetAppNames],
      [DockCmd::REG_PROTOCOL_EXTENSION, :DockCmdRegProtocolExtension],
      [DockCmd::REMOVE_PROTOCOL_EXTENSION, :DockCmdRemoveProtocolExtension],
      [DockCmd::SET_STORE_SIGNATURE, :DockCmdSetStoreSignature],
      [DockCmd::SET_SOUP_SIGNATURE, :DockCmdSetSoupSignature],
      [DockCmd::IMPORT_PARAMETERS_SLIP, :DockCmdImportParametersSlip],
      [DockCmd::GET_PASSWORD, :DockCmdGetPassword],
      [DockCmd::SEND_SOUP, :DockCmdSendSoup],
      [DockCmd::BACKUP_SOUP, :DockCmdBackupSoup],
      [DockCmd::SET_STORE_NAME, :DockCmdSetStoreName],
      [DockCmd::CALL_GLOBAL_FUNCTION, :DockCmdCallGlobalFunction],
      [DockCmd::CALL_ROOT_METHOD, :DockCmdCallRootMethod],
      [DockCmd::SET_VBOCOMPRESSION, :DockCmdSetVBOCompression],
      [DockCmd::RESTORE_PATCH, :DockCmdRestorePatch],
      [DockCmd::OPERATION_DONE, :DockCmdOperationDone],
      [DockCmd::OPERATION_CANCELED, :DockCmdOperationCanceled],
      [DockCmd::OPERATION_CANCELED2, :DockCmdOperationCanceled],
      [DockCmd::OP_CANCELED_ACK, :DockCmdOpCanceledAck],
      [DockCmd::REF_TEST, :DockCmdRefTest],
      [DockCmd::UNKNOWN_COMMAND, :DockCmdUnknownCommand],
      [DockCmd::PASSWORD, :DockCmdPassword],
      [DockCmd::NEWTON_NAME, :DockCmdNewtonName],
      [DockCmd::NEWTON_INFO, :DockCmdNewtonInfo],
      [DockCmd::INITIATE_DOCKING, :DockCmdInitiateDocking],
      [DockCmd::DESKTOP_INFO, :DockCmdDesktopInfo],
      [DockCmd::WHICH_ICONS, :DockCmdWhichIcons],
      [DockCmd::REQUEST_TO_SYNC, :DockCmdRequestToSync],
      [DockCmd::SYNC_OPTIONS, :DockCmdSyncOptions],
      [DockCmd::GET_SYNC_OPTIONS, :DockCmdGetSyncOptions],
      [DockCmd::SYNC_RESULTS, :DockCmdSyncResults],
      [DockCmd::SET_STORE_GET_NAMES, :DockCmdSetStoreGetNames],
      [DockCmd::SET_SOUP_GET_INFO, :DockCmdSetSoupGetInfo],
      [DockCmd::GET_CHANGED_INDEX, :DockCmdGetChangedIndex],
      [DockCmd::GET_CHANGED_INFO, :DockCmdGetChangedInfo],
      [DockCmd::REQUEST_TO_BROWSE, :DockCmdRequestToBrowse],
      [DockCmd::GET_DEVICES, :DockCmdGetDevices],
      [DockCmd::GET_DEFAULT_PATH, :DockCmdGetDefaultPath],
      [DockCmd::GET_FILES_AND_FOLDERS, :DockCmdGetFilesAndFolders],
      [DockCmd::SET_PATH, :DockCmdSetPath],
      [DockCmd::GET_FILE_INFO, :DockCmdGetFileInfo],
      [DockCmd::INTERNAL_STORE, :DockCmdInternalStore],
      [DockCmd::RESOLVE_ALIAS, :DockCmdResolveAlias],
      [DockCmd::GET_FILTERS, :DockCmdGetFilters],
      [DockCmd::SET_FILTER, :DockCmdSetFilter],
      [DockCmd::SET_DRIVE, :DockCmdSetDrive],
      [DockCmd::DEVICES, :DockCmdDevices],
      [DockCmd::FILTERS, :DockCmdFilters],
      [DockCmd::PATH, :DockCmdPath],
      [DockCmd::FILES_AND_FOLDERS, :DockCmdFilesAndFolders],
      [DockCmd::FILE_INFO, :DockCmdFileInfo],
      [DockCmd::GET_INTERNAL_STORE, :DockCmdGetInternalStore],
      [DockCmd::ALIAS_RESOLVED, :DockCmdAliasResolved],
      [DockCmd::IMPORT_FILE, :DockCmdImportFile],
      [DockCmd::SET_TRANSLATOR, :DockCmdSetTranslator],
      [DockCmd::TRANSLATOR_LIST, :DockCmdTranslatorList],
      [DockCmd::IMPORTING, :DockCmdImporting],
      [DockCmd::SOUPS_CHANGED, :DockCmdSoupsChanged],
      [DockCmd::SET_STORE_TO_DEFAULT, :DockCmdSetStoreToDefault],
      [DockCmd::LOAD_PACKAGE_FILE, :DockCmdLoadPackageFile],
      [DockCmd::RESTORE_FILE, :DockCmdRestoreFile],
      [DockCmd::GET_RESTORE_OPTIONS, :DockCmdGetRestoreOptions],
      [DockCmd::RESTORE_ALL, :DockCmdRestoreAll],
      [DockCmd::RESTORE_OPTIONS, :DockCmdRestoreOptions],
      [DockCmd::RESTORE_PACKAGE, :DockCmdRestorePackage],
      [DockCmd::REQUEST_TO_RESTORE, :DockCmdRequestToRestore],
      [DockCmd::REQUEST_TO_INSTALL, :DockCmdRequestToInstall],
      [DockCmd::REQUEST_TO_DOCK, :DockCmdRequestToDock],
      [DockCmd::CURRENT_TIME, :DockCmdCurrentTime],
      [DockCmd::STORE_NAMES, :DockCmdStoreNames],
      [DockCmd::SOUP_NAMES, :DockCmdSoupNames],
      [DockCmd::SOUP_IDS, :DockCmdSoupIDs],
      [DockCmd::CHANGED_IDS, :DockCmdChangedIDs],
      [DockCmd::RESULT, :DockCmdResult],
      [DockCmd::ADDED_ID, :DockCmdAddedID],
      [DockCmd::ENTRY, :DockCmdEntry],
      [DockCmd::PACKAGE_IDLIST, :DockCmdPackageIDList],
      [DockCmd::PACKAGE, :DockCmdPackage],
      [DockCmd::INDEX_DESCRIPTION, :DockCmdIndexDescription],
      [DockCmd::INHERITANCE, :DockCmdInheritance],
      [DockCmd::PATCHES, :DockCmdPatches],
      [DockCmd::LAST_SYNC_TIME, :DockCmdLastSyncTime],
      [DockCmd::GET_STORE_NAMES, :DockCmdGetStoreNames],
      [DockCmd::GET_SOUP_NAMES, :DockCmdGetSoupNames],
      [DockCmd::SET_CURRENT_STORE, :DockCmdSetCurrentStore],
      [DockCmd::SET_CURRENT_SOUP, :DockCmdSetCurrentSoup],
      [DockCmd::GET_SOUP_IDS, :DockCmdGetSoupIDs],
      [DockCmd::GET_CHANGED_IDS, :DockCmdGetChangedIDs],
      [DockCmd::DELETE_ENTRIES, :DockCmdDeleteEntries],
      [DockCmd::ADD_ENTRY, :DockCmdAddEntry],
      [DockCmd::RETURN_ENTRY, :DockCmdReturnEntry],
      [DockCmd::RETURN_CHANGED_ENTRY, :DockCmdReturnChangedEntry],
      [DockCmd::EMPTY_SOUP, :DockCmdEmptySoup],
      [DockCmd::DELETE_SOUP, :DockCmdDeleteSoup],
      [DockCmd::LOAD_PACKAGE, :DockCmdLoadPackage],
      [DockCmd::GET_PACKAGE_IDS, :DockCmdGetPackageIDs],
      [DockCmd::BACKUP_PACKAGES, :DockCmdBackupPackages],
      [DockCmd::DISCONNECT, :DockCmdDisconnect],
      [DockCmd::DELETE_ALL_PACKAGES, :DockCmdDeleteAllPackages],
      [DockCmd::GET_INDEX_DESCRIPTION, :DockCmdGetIndexDescription],
      [DockCmd::CREATE_SOUP, :DockCmdCreateSoup],
      [DockCmd::GET_INHERITANCE, :DockCmdGetInheritance],
      [DockCmd::SET_TIMEOUT, :DockCmdSetTimeout],
      [DockCmd::GET_PATCHES, :DockCmdGetPatches],
      [DockCmd::DELETE_PKG_DIR, :DockCmdDeletePkgDir],
      [DockCmd::GET_SOUP_INFO, :DockCmdGetSoupInfo],
      [DockCmd::CHANGED_ENTRY, :DockCmdChangedEntry],
      [DockCmd::TEST, :DockCmdTest],
      [DockCmd::HELLO, :DockCmdHello],
      [DockCmd::SOUP_INFO, :DockCmdSoupInfo],
      [DockCmd::UNKNOWN_DSNC, :DockCmdUnknowndsnc],
    ]

    def DockCmdFactory.from_binary_factory(b)
      class_symbol = nil
      c = b.unpack("A4A4A4N")
      COMMAND_MAP.each do |cmd|
        if cmd[0] == c[2]
          class_symbol = cmd[1]
        end
      end
      r = RDCL.const_get(class_symbol).new
      r.from_binary(b)
      return r
    end

  end
  
end