/*
** Copyright 2007, The Android Open Source Project
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
*/

package com.android.internal.telephony;

import android.content.ContentValues;

import com.android.internal.telephony.uicc.AdnRecord;
import com.mediatek.internal.telephony.uicc.AlphaTag;
import com.mediatek.internal.telephony.uicc.UsimGroup;
import com.mediatek.internal.telephony.uicc.UsimPBMemInfo;



/** Interface for applications to access the ICC phone book.
 *
 * <p>The following code snippet demonstrates a static method to
 * retrieve the IIccPhoneBook interface from Android:</p>
 * <pre>private static IIccPhoneBook getSimPhoneBookInterface()
            throws DeadObjectException {
    IServiceManager sm = ServiceManagerNative.getDefault();
    IIccPhoneBook spb;
    spb = IIccPhoneBook.Stub.asInterface(sm.getService("iccphonebook"));
    return spb;
}
 * </pre>
 */

interface IIccPhoneBook {

    /**
     * Loads the AdnRecords in efid and returns them as a
     * List of AdnRecords
     *
     * @param efid the EF id of a ADN-like SIM
     * @return List of AdnRecord
     */
    List<AdnRecord> getAdnRecordsInEf(int efid);

    /**
     * Loads the AdnRecords in efid and returns them as a
     * List of AdnRecords
     *
     * @param efid the EF id of a ADN-like SIM
     * @param subId user preferred subId
     * @return List of AdnRecord
     */
    List<AdnRecord> getAdnRecordsInEfForSubscriber(int subId, int efid);

    /**
     * Replace oldAdn with newAdn in ADN-like record in EF
     *
     * getAdnRecordsInEf must be called at least once before this function,
     * otherwise an error will be returned
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param oldTag adn tag to be replaced
     * @param oldPhoneNumber adn number to be replaced
     *        Set both oldTag and oldPhoneNubmer to "" means to replace an
     *        empty record, aka, insert new record
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number ot be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @return true for success
     */
    boolean updateAdnRecordsInEfBySearch(int efid,
            String oldTag, String oldPhoneNumber,
            String newTag, String newPhoneNumber,
            String pin2);
/**
     * Replace oldAdn with newAdn in ADN-like record in EF
     *
     * getAdnRecordsInEf must be called at least once before this function,
     * otherwise an error will be returned.
     *
     * This method will return why the error occurs.
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param oldTag adn tag to be replaced
     * @param oldPhoneNumber adn number to be replaced
     *        Set both oldTag and oldPhoneNubmer to "" means to replace an
     *        empty record, aka, insert new record
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number ot be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
    * @hide
     * @internal
     */
    int
    updateAdnRecordsInEfBySearchWithError(int subId, int efid,
            String oldTag, String oldPhoneNumber,
            String newTag, String newPhoneNumber, String pin2);

    /**
     * Replace old USIM phonebook contacts with new USIM phonebook contacts 
     *
     * getAdnRecordsInEf must be called at least once before this function,
     * otherwise an error will be returned.
     *
    * This method will return why the error occurs.
     *
     * @param efid must be EF_ADN
     * @param oldTag adn tag to be replaced
     * @param oldPhoneNumber adn number to be replaced
     * @param oldAnr additional number string for the adn record.
     * @param oldGrpIds group id list for the adn record.
     * @param oldEmails Emails for the adn record.     
     *        Set both oldTag and oldPhoneNubmer to "" means to replace an
     *        empty record, aka, insert new record
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number ot be stored
     * @param newAnr  new additional number string to be stored 
     * @param newGrpIds group id list for the adn record.
     * @param newEmails Emails for the adn record.  
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
     * @hide
     * @internal
     */
    int
    updateUsimPBRecordsInEfBySearchWithError(int subId, int efid,
            String oldTag, String oldPhoneNumber,String oldAnr, in String oldGrpIds, in String[] oldEmails,
            String newTag, String newPhoneNumber, String newAnr, in String newGrpIds, in String[] newEmails);



    /**
     * Replace oldAdn with newAdn in ADN-like record in EF
     *
     * getAdnRecordsInEf must be called at least once before this function,
     * otherwise an error will be returned
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param oldTag adn tag to be replaced
     * @param oldPhoneNumber adn number to be replaced
     *        Set both oldTag and oldPhoneNubmer to "" means to replace an
     *        empty record, aka, insert new record
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number ot be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @param subId user preferred subId
     * @return true for success
     */
    boolean updateAdnRecordsInEfBySearchForSubscriber(int subId, int efid,
            String oldTag, String oldPhoneNumber,
            String newTag, String newPhoneNumber,
            String pin2);

    /**
     * Replace oldAdn with newAdn in ADN-like record in EF
     *
     * getAdnRecordsInEf must be called at least once before this function,
     * otherwise an error will be returned
     *
     * @param subId user preferred subId
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param values including ADN,EMAIL,ANR to be updated
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @return true for success
     */
    boolean updateAdnRecordsWithContentValuesInEfBySearchUsingSubId(int subId,
            int efid, in ContentValues values, String pin2);

    /**
     * Update an ADN-like EF record by record index
     *
     * This is useful for iteration the whole ADN file, such as write the whole
     * phone book or erase/format the whole phonebook
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number to be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param index is 1-based adn record index to be updated
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @return true for success
     */
    boolean updateAdnRecordsInEfByIndex(int efid, String newTag,
            String newPhoneNumber, int index,
            String pin2);

    /**
     * Update an ADN-like EF record by record index
     *
     * This is useful for iteration the whole ADN file, such as write the whole
     * phone book or erase/format the whole phonebook
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number to be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param index is 1-based adn record index to be updated
     * @param pin2 required to update EF_FDN, otherwise must be null
     * @param subId user preferred subId
     * @return true for success
     */
    boolean updateAdnRecordsInEfByIndexForSubscriber(int subId, int efid, String newTag,
            String newPhoneNumber, int index,
            String pin2);
/**
     * Update an ADN-like EF record by record index
     *
     * This is useful for iteration the whole ADN file, such as write the whole
     * phone book or erase/format the whole phonebook.
     *
    * This method will return why the error occurs
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number to be stored
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param index is 1-based adn record index to be updated
     * @param pin2 required to update EF_FDN, otherwise must be null
    * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
     * @hide
     * @internal
     */
    int
   updateAdnRecordsInEfByIndexWithError(int subId, int efid, String newTag,
            String newPhoneNumber, int index, String pin2);

    /**
     * Update an USIM phonebook contacts by record index
     *
    * This is useful for iteration the whole ADN file, such as write the whole
     * phone book or erase/format the whole phonebook.
     *
     * This method will return why the error occurs
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param newTag adn tag to be stored
     * @param newPhoneNumber adn number to be stored
     * @param newAnr  new additional number string to be stored 
     * @param newGrpIds group id list for the adn record.
     * @param newEmails Emails for the adn record.     
     *        Set both newTag and newPhoneNubmer to "" means to replace the old
     *        record with empty one, aka, delete old record
     * @param index is 1-based adn record index to be updated
     * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
     * @hide
    * @internal
     */
    int
    updateUsimPBRecordsInEfByIndexWithError(int subId, int efid, String newTag,
            String newPhoneNumber, String newAnr,  in String newGrpIds, in String[] newEmails, int index);

    /**
    * Update an USIM phonebook contacts by record index
     *
     * This is useful for iteration the whole USIM ADN file, such as write the whole
     * phone book or erase/format the whole phonebook.
     *
     * This method will return why the error occurs
     *
    * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param record adn record to be stored
     * @param index is 1-based adn record index to be updated
     * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
     * @hide
    * @internal
     */
    int updateUsimPBRecordsByIndexWithError(int subId, int efid, in AdnRecord record, int index);

    /**
     * Update an USIM phonebook contacts by old record information
     *
     * This is useful for iteration the whole USIM ADN file, such as write the whole
     * phone book or erase/format the whole phonebook.
     *
    * This method will return why the error occurs
     *
     * @param efid must be one among EF_ADN, EF_FDN, and EF_SDN
     * @param oldAdn adn record to be replaced
     * @param newAdn adn record to be stored
     * @return ERROR_ICC_PROVIDER_* defined in the IccProvider
     *
     * @hide
     * @internal
     */
    int updateUsimPBRecordsBySearchWithError(int subId, int efid, in AdnRecord oldAdn, in AdnRecord newAdn);
    /**
     * Get the max munber of records in efid
     *
     * @param efid the EF id of a ADN-like SIM
     * @return  int[3] array
     *            recordSizes[0]  is the single record length
     *            recordSizes[1]  is the total length of the EF file
     *            recordSizes[2]  is the number of records in the EF file
     */
    int[] getAdnRecordsSize(int efid);

    /**
     * Get the max munber of records in efid
     *
     * @param efid the EF id of a ADN-like SIM
     * @param subId user preferred subId
     * @return  int[3] array
     *            recordSizes[0]  is the single record length
     *            recordSizes[1]  is the total length of the EF file
     *            recordSizes[2]  is the number of records in the EF file
     */
    int[] getAdnRecordsSizeForSubscriber(int subId, int efid);
    
    

    /**
     * Get the adn count of sim card
     *
     * @return the adn count of sim card
     */
    int getAdnCount();

    /**
     * Get the adn count of sim card
     *
     * @param subId user preferred subId
     * @return the adn count of sim card
     */
    int getAdnCountUsingSubId(int subId);

    /**
     * Get the anr count of sim card
     *
     * @return the anr count of sim card
     */
    int getAnrCount();

    /**
     * Get the anr count of sim card
     *
     * @param subId user preferred subId
     * @return the anr count of sim card
     */
    int getAnrCountUsingSubId(int subId);

    /**
     * Get the email count of sim card
     *
     * @return the email count of sim card
     */
    int getEmailCount();

    /**
     * Get the email count of sim card
     *
     * @param subId user preferred subId
     * @return the email count of sim card
     */
    int getEmailCountUsingSubId(int subId);

    /**
     * Get the spare anr count of sim card
     *
     * @return the spare anr count of sim card
     */
    int getSpareAnrCount();

    /**
     * Get the spare anr count of sim card
     *
     * @param subId user preferred subId
     * @return the spare anr count of sim card
     */
    int getSpareAnrCountUsingSubId(int subId);

    /**
     * Get the spare email count of sim card
     *
     * @return the spare email count of sim card
     */
    int getSpareEmailCount();

    /**
     * Get the spare email count of sim card
     *
     * @param subId user preferred subId
     * @return the spare email count of sim card
     */
    int getSpareEmailCountUsingSubId(int subId);
      /**
     * Judge if the PHB subsystem is ready or not
     *
     * @return  true for ready
     * @hide
     * @internal
     */
    boolean isPhbReady(int subId);

    /**
     * Get groups list of USIM phonebook
     *
     * This is useful for getting groups list  of USIM phonebook 
     *
     * This method will return null if phonebook not ready
     *
     * @return UsimGroup list 
     *
     * @hide
     * @internal
     */
    List<UsimGroup> getUsimGroups(int subId);

    /**
     * Get indicated group name of USIM phonebook by group id
     *
     * This method will return null if phonebook not ready
     *
     * @param nGasId  given group id use to query group name
     * @return group name of indicated id 
     *
     * @hide
     * @internal
     */
    String getUsimGroupById(int subId, int nGasId);

    /**
     * Remove  indicated group from USIM phonebook by group id
     *
     * This method will return false if phonebook not ready
     *
     * @param nGasId  given group id use to query group name
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean removeUsimGroupById(int subId, int nGasId);

    /**
     * Insert a new group to USIM phonebook by given name
     *
     * This method will return -1 if phonebook not ready
     *
     * @param grpName  new added group name
     * @return group id of inserted group
     *
     * @hide
     * @internal
     */
    int insertUsimGroup(int subId, String grpName);

    /**
     * Update group name to USIM phonebook by id and new name
     *
     * This method will return -1 if phonebook not ready
     *
     * @param nGasId group id need to update     
     * @param grpName new group name
     * @return group id of inserted group
     *
     * @hide
     * @internal
     */
    int updateUsimGroup(int subId, int nGasId, String grpName);

    /**
     * Add contact to indicated group by given contact index and group id
     *
     * This method will return false if phonebook not ready
     *
     * @param adnIndex  contact id which you want to add it to a group
     * @param grpIndex  group id 
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean addContactToGroup(int subId, int adnIndex, int grpIndex);

    /**
     * Remove contact from indicated group by given contact index and group id
     *
     * This method will return false if phonebook not ready
     *
     * @param adnIndex  contact id which you want to remove it from a group
     * @param grpIndex  group id 
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean removeContactFromGroup(int subId, int adnIndex, int grpIndex);

    /**
     * Update contact to indicated group list by given contact index and group id
     *
     * This method will return false if phonebook not ready
     *
     * @param adnIndex  contact id which you want to update it to groups
     * @param grpIdList  group id list
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean updateContactToGroups(int subId, int adnIndex, in int[] grpIdList);

    /**
     * Move contact from and to indicated group list by given contact index and group id
     *
     * This method will return false if phonebook not ready
     *
     * @param adnIndex       contact id which you want to update it to groups
     * @param fromGrpIdList  group id list that want to remove
     * @param toGrpIdList    group id list that want to add
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean moveContactFromGroupsToGroups(int subId, int adnIndex, in int[] fromGrpIdList, in int[] toGrpIdList);

    /**
     * Check if there is the same group in USIM phonebook
     *
     * This method will return -1  if phonebook not ready
     *
     * @param grpName group name
     * @return 1 if there is a same group name
     *
     * @hide
     * @internal
     */
    int hasExistGroup(int subId, String grpName);

     /**
     * Get the maximum group name limitation of USIM group
     *
     * This method will return -1  if phonebook not ready
     *
     * @return length of name limitation
     *
     * @hide
     * @internal
     */
    int getUsimGrpMaxNameLen(int subId);

    /**
     * Get the maximum group number limitation of USIM group
     *
     * This method will return -1  if phonebook not ready
     *
     * @return number of group limitation
     *
     * @hide
     * @internal
     */
    int getUsimGrpMaxCount(int subId);

    /**
     * Get name list of adtional number
     *
     * This method will return null  if phonebook not ready
     *
     * @return aditional number string list
     *
     * @hide
     * @internal
     */
    List<AlphaTag> getUsimAasList(int subId);

    /**
     * Get name of indicated adtional number by given index
     *
     * This method will return null  if phonebook not ready
     *
     * @param index AAS index
     * @return indicated aditional number string
     *
     * @hide
     * @internal
     */
    String getUsimAasById(int subId, int index);

    /**
     * Insert name of adtional number
     *
     * This method will return -1  if phonebook not ready
     *
     * @param aasName AAS name
     * @return index of new added aditional number name
     *
     * @hide
     * @internal
     */
    int insertUsimAas(int subId, String aasName);

    /**
     * Get number of aditional number count
     *
     * This method will return -1  if phonebook not ready
     *
     * @return aditional number count
     *
     * @hide
     * @internal
     */
    int getAnrCount(int subId);

     /**
     * Get number of email field count
     *
     * This method will return 0  if phonebook not ready
     *
     * @return email field
     *
     * @hide
     * @internal
     */
    int getEmailCount(int subId);

     /**
     * Get count of aditional number name limitation
     *
     * This method will return -1  if phonebook not ready
     *
     * @return aditional number name count limitation
     *
     * @hide
     * @internal
     */
    int getUsimAasMaxCount(int subId);

    /**
     * Get length of aditional number name limitation
     *
     * This method will return -1  if phonebook not ready
     *
     * @return aditional number name length limitaion
     *
     * @hide
     * @internal
     */
    int getUsimAasMaxNameLen(int subId);

    /**
     * Update aditional number name by given index and new name
     *
     * This method will return false  if phonebook not ready
     *
     * @param index  AAS index
     * @param pbrIndex  PBR index 
     * @param aasName  new AAS name
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean updateUsimAas(int subId, int index, int pbrIndex, String aasName);

    /**
     * Remove aditional number name by given index 
     *
     * This method will return false  if phonebook not ready
     *
     * @param index  AAS index
     * @param pbrIndex  PBR index 
     * @return true if the operation is successful
     *
     * @hide
     * @internal
     */
    boolean removeUsimAasById(int subId, int index, int pbrIndex);

    /**
     * Check if support SNE functionility
     *
     * This method will return false  if phonebook not ready
     *
     * @return true if SNE is supported
     *
     * @hide
     * @internal
     */
    boolean hasSne(int subId);

    /**
     * Get SNE record length
     *
     * This method will return -1  if phonebook not ready
     *
     * @return SNE record length
     *
     * @hide
     * @internal
     */
    int getSneRecordLen(int subId);

    /**
     * @hide
     * @internal
    */
    boolean isAdnAccessible(int subId);

    /**
     * Get memory storage information of USIM phonebook
     *
     * This method will return null  if phonebook not ready
     *
     * @return UsimPBMemInfo array for memory storage
     *
     * @hide
     * @internal
     */
    UsimPBMemInfo[] getPhonebookMemStorageExt(int subId);
    /**
     * This method will if the sim card is UICC card
     *
     * @return is Uicc Card
     *
     * @hide
     * @internal
     */  
    boolean isUICCCard(int subId);
}
