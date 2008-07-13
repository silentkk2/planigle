class ResourceController < ApplicationController

  # GET /records
  # GET /records.xml
  def index
    @records = get_records
    respond_to do |format|
      format.xml { render :xml => @records }
      format.amf { render :amf => @records }
    end
  end
  
  # GET /records/1
  # GET /records/1.xml
  def show
    @record = get_record
    if (authorized_for_read?(@record))
      respond_to do |format|
        format.xml { render :xml => @record }
        format.amf { render :amf => @record }
      end
    else
      unauthorized
    end
  end

  # POST /records
  # POST /records.xml
  def create
    @record = create_record
    if (authorized_for_create?(@record))
      respond_to do |format|
        if @record.save
          format.xml { render :xml => @record, :status => :created }
          format.amf { render :amf => @record }
        else
          format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
          format.amf { render :amf => @record.errors.full_messages }
        end
      end
    else
      unauthorized
    end
  end
  
  # PUT /records/1
  # PUT /records/1.xml
  def update
    @record = get_record
    if (authorized_for_update?(@record))
      update_record
      respond_to do |format|
        if @record.save
          format.xml { render :xml => @record }
          format.amf { render :amf => @record }
        else
          format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
          format.amf { render :amf => @record.errors.full_messages }
        end
      end
    else
      unauthorized
    end
  end

  # DELETE /records/1
  # DELETE /records/1.xml
  def destroy
    @record = get_record
    if (authorized_for_destroy?(@record))
      @record.destroy
      respond_to do |format|
        format.xml { render :xml => @record }
        format.amf { render :amf => @record }
      end
    else
      unauthorized
    end
  end
  
protected

  # Answer if this request is authorized for create.
  def authorized_for_create?(record)
    record.authorized_for_create?(current_individual)
  end

  # Answer if this request is authorized for read.
  def authorized_for_read?(record)
    record.authorized_for_read?(current_individual)
  end

  # Answer if this request is authorized for update.
  def authorized_for_update?(record)
    record.authorized_for_update?(current_individual)
  end

  # Answer if this request is authorized for delete.
  def authorized_for_destroy?(record)
    record.authorized_for_destroy?(current_individual)
  end
end